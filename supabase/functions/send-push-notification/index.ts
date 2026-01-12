// Supabase Edge Function: Send Web Push notifications
// This function sends push notifications to users even when their browser is closed

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
// @deno-types="https://esm.sh/web-push@3.6.6/index.d.ts"
import * as webpush from 'https://esm.sh/web-push@3.6.6'

const VAPID_PRIVATE_KEY = Deno.env.get('VAPID_PRIVATE_KEY')
const VAPID_PUBLIC_KEY = Deno.env.get('VAPID_PUBLIC_KEY')
const VAPID_SUBJECT = Deno.env.get('VAPID_SUBJECT') || 'mailto:notifications@lastcall.work'

// CORS headers
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface PushNotificationRequest {
  user_id: string
  user_type: 'worker' | 'business'
  title: string
  body: string
  icon?: string
  badge?: string
  tag?: string
  data?: any
  url?: string
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    if (!VAPID_PRIVATE_KEY || !VAPID_PUBLIC_KEY) {
      return new Response(
        JSON.stringify({ error: 'VAPID keys not configured' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const { user_id, user_type, title, body, icon, badge, tag, data, url } = await req.json() as PushNotificationRequest

    if (!user_id || !user_type || !title || !body) {
      return new Response(
        JSON.stringify({ error: 'Missing required fields: user_id, user_type, title, body' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Initialize Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Get user's push subscription
    const table = user_type === 'business' ? 'businesses' : 'workers'
    const { data: userData, error: userError } = await supabase
      .from(table)
      .select('push_subscription')
      .eq('id', user_id)
      .single()

    if (userError || !userData || !userData.push_subscription) {
      return new Response(
        JSON.stringify({ message: 'User not found or no push subscription', sent: false }),
        { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const subscription = typeof userData.push_subscription === 'string' 
      ? JSON.parse(userData.push_subscription)
      : userData.push_subscription

    // Set VAPID details for web-push
    webpush.setVapidDetails(
      VAPID_SUBJECT,
      VAPID_PUBLIC_KEY!,
      VAPID_PRIVATE_KEY!
    )

    // Prepare push notification payload
    const pushPayload = JSON.stringify({
      title,
      body,
      icon: icon || 'https://lastcall.work/icon-192x192.png',
      badge: badge || 'https://lastcall.work/badge-72x72.png',
      tag: tag || 'lastcall-notification',
      data: {
        url: url || 'https://lastcall.work',
        ...data
      }
    })

    // Send push notification using web-push library
    try {
      await webpush.sendNotification(
        subscription as webpush.PushSubscription,
        pushPayload
      )

      return new Response(
        JSON.stringify({ 
          message: 'Push notification sent successfully',
          sent: true
        }),
        { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    } catch (pushError) {
      console.error('Error sending push notification:', pushError)
      return new Response(
        JSON.stringify({ 
          error: 'Failed to send push notification',
          details: pushError.message
        }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }
  } catch (error) {
    console.error('Error in send-push-notification function:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
