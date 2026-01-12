// Supabase Edge Function: Send email notifications to workers when a new shift is posted
// This function is triggered when a business posts a new shift

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
// @deno-types="https://esm.sh/web-push@3.6.6/index.d.ts"
import * as webpush from 'https://esm.sh/web-push@3.6.6'

const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')
const FROM_EMAIL = Deno.env.get('FROM_EMAIL') || 'notifications@lastcall.work'
const VAPID_PRIVATE_KEY = Deno.env.get('VAPID_PRIVATE_KEY')
const VAPID_PUBLIC_KEY = Deno.env.get('VAPID_PUBLIC_KEY')
const VAPID_SUBJECT = Deno.env.get('VAPID_SUBJECT') || 'mailto:notifications@lastcall.work'

interface Shift {
  id: string
  business_id: string
  position: string
  shift_date: string
  start_time: string
  end_time: string
  hourly_rate: number
  tips_included: boolean
  age_requirement: string
  notes?: string
}

interface Business {
  id: string
  business_name: string
  address?: string
}

interface Worker {
  id: string
  email: string
  full_name: string
  positions: string[]
  email_notifications_enabled: boolean
}

// CORS headers
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Get the shift data from the request
    const { shift, business } = await req.json() as { shift: Shift; business: Business }

    if (!shift || !business) {
      return new Response(
        JSON.stringify({ error: 'Missing shift or business data' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Initialize Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Check if test mode is active (if any test accounts exist, only send to test accounts)
    const { data: testAccounts, error: testCheckError } = await supabase
      .from('workers')
      .select('id')
      .eq('test_account', true)
      .limit(1);
    
    const testMode = testAccounts && testAccounts.length > 0;

    // Find all workers who:
    // 1. Have this position in their positions array
    // 2. Have email notifications enabled
    // 3. Are available
    // 4. If test mode is active, only include test accounts
    let workersQuery = supabase
      .from('workers')
      .select('id, email, full_name, positions, email_notifications_enabled, push_subscription')
      .eq('available', true)
      .eq('email_notifications_enabled', true)
      .contains('positions', [shift.position]);

    // If test mode is active, only send to test accounts
    if (testMode) {
      workersQuery = workersQuery.eq('test_account', true);
    }

    const { data: workers, error: workersError } = await workersQuery

    if (workersError) {
      console.error('Error fetching workers:', workersError)
      return new Response(
        JSON.stringify({ error: 'Failed to fetch workers' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (!workers || workers.length === 0) {
      console.log('No workers found matching criteria:', {
        position: shift.position,
        testMode: testMode,
        available: true,
        email_notifications_enabled: true
      })
      return new Response(
        JSON.stringify({ 
          message: 'No workers to notify', 
          notified: 0,
          debug: {
            position: shift.position,
            testMode: testMode,
            criteria: 'available=true, email_notifications_enabled=true, position matches'
          }
        }),
        { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    console.log(`Found ${workers.length} worker(s) to notify for ${shift.position} shift`)

    // Format the shift date and time
    const shiftDate = new Date(shift.shift_date).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })

    // Format time (convert from 24h to 12h)
    const formatTime = (time: string) => {
      const [hours, minutes] = time.split(':')
      const hour = parseInt(hours)
      const ampm = hour >= 12 ? 'PM' : 'AM'
      const hour12 = hour % 12 || 12
      return `${hour12}:${minutes} ${ampm}`
    }

    const startTime = formatTime(shift.start_time)
    const endTime = formatTime(shift.end_time)

    // Calculate pay info
    const payInfo = shift.tips_included 
      ? `$${shift.hourly_rate.toFixed(2)}/hr (tips included)`
      : `$${shift.hourly_rate.toFixed(2)}/hr + tips`

    // Age requirement text
    const ageText = shift.age_requirement === '21' ? '21+' : '18+'

    // Send emails to all matching workers
    const emailPromises = (workers as Worker[]).map(async (worker) => {
      const emailBody = `
        <!DOCTYPE html>
        <html>
        <head>
          <style>
            body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
            .container { max-width: 600px; margin: 0 auto; padding: 20px; }
            .header { background: #1e293b; color: white; padding: 20px; border-radius: 8px 8px 0 0; }
            .content { background: #f8f9fa; padding: 20px; border-radius: 0 0 8px 8px; }
            .shift-details { background: white; padding: 15px; margin: 15px 0; border-radius: 4px; border-left: 4px solid #3b82f6; }
            .button { display: inline-block; background: #3b82f6; color: white; padding: 16px 32px; text-decoration: none; border-radius: 6px; margin-top: 20px; font-weight: bold; font-size: 16px; text-align: center; box-shadow: 0 2px 4px rgba(0,0,0,0.2); }
            .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
          </style>
        </head>
        <body>
          <div class="container">
            <div class="header">
              <h1>📋 New Shift Available on LastCall!</h1>
            </div>
            <div class="content">
              <p>Hi ${worker.full_name},</p>
              <p>A new shift matching your position has been posted!</p>
              
              <div class="shift-details">
                <h3>${business.business_name}</h3>
                <p><strong>Position:</strong> ${shift.position}</p>
                <p><strong>Date:</strong> ${shiftDate}</p>
                <p><strong>Time:</strong> ${startTime} - ${endTime}</p>
                <p><strong>Pay:</strong> ${payInfo}</p>
                <p><strong>Age Requirement:</strong> ${ageText}</p>
                ${shift.notes ? `<p><strong>Notes:</strong> ${shift.notes}</p>` : ''}
                ${business.address ? `<p><strong>Location:</strong> ${business.address}</p>` : ''}
              </div>
              
              <div style="text-align: center; margin-top: 20px;">
                <a href="https://lastcall.work" class="button">View Shift on LastCall</a>
              </div>
              
              <p style="margin-top: 20px; font-size: 14px; color: #666;">
                This shift may fill quickly, so don't wait!
              </p>
            </div>
            <div class="footer">
              <p>You're receiving this because you have email notifications enabled.</p>
              <p>Manage your notification preferences in your LastCall profile settings.</p>
            </div>
          </div>
        </body>
        </html>
      `

      // Use Resend API to send email
      if (!RESEND_API_KEY) {
        console.error('RESEND_API_KEY not configured')
        return { success: false, worker: worker.email, error: 'Email service not configured' }
      }

      try {
        const resendResponse = await fetch('https://api.resend.com/emails', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${RESEND_API_KEY}`
          },
          body: JSON.stringify({
            from: FROM_EMAIL,
            to: worker.email,
            subject: `New ${shift.position} Shift Available - ${business.business_name}`,
            html: emailBody
          })
        })

        if (!resendResponse.ok) {
          const errorData = await resendResponse.text()
          console.error(`Failed to send email to ${worker.email}:`, errorData)
          return { success: false, worker: worker.email, error: errorData }
        }

        return { success: true, worker: worker.email }
      } catch (error) {
        console.error(`Error sending email to ${worker.email}:`, error)
        return { success: false, worker: worker.email, error: error.message }
      }
    })

    const results = await Promise.all(emailPromises)
    const successCount = results.filter(r => r.success).length
    
    console.log(`Email sending results: ${successCount} successful, ${results.length - successCount} failed`)
    results.forEach((result, index) => {
      if (!result.success) {
        console.error(`Failed to send email to ${workers[index].email}:`, result.error)
      } else {
        console.log(`Successfully sent email to ${workers[index].email}`)
      }
    })

    // Send push notifications to workers who have subscriptions
    let pushCount = 0
    if (VAPID_PRIVATE_KEY && VAPID_PUBLIC_KEY) {
      webpush.setVapidDetails(VAPID_SUBJECT, VAPID_PUBLIC_KEY, VAPID_PRIVATE_KEY)
      
      for (const worker of workers) {
        if (worker.push_subscription) {
          try {
            const subscription = typeof worker.push_subscription === 'string' 
              ? JSON.parse(worker.push_subscription)
              : worker.push_subscription

            const pushPayload = JSON.stringify({
              title: `New ${shift.position} Shift Available!`,
              body: `${business.business_name} posted a ${shift.position} shift on ${shiftDate}`,
              icon: 'https://lastcall.work/icon-192x192.png',
              badge: 'https://lastcall.work/badge-72x72.png',
              tag: `shift-${shift.id}`,
              data: {
                url: 'https://lastcall.work'
              }
            })

            await webpush.sendNotification(
              subscription as webpush.PushSubscription,
              pushPayload
            )
            pushCount++
            console.log(`Push notification sent to worker ${worker.id}`)
          } catch (pushError) {
            console.error(`Failed to send push to worker ${worker.id}:`, pushError)
            // If subscription is invalid, remove it
            if (pushError.statusCode === 410) {
              await supabase
                .from('workers')
                .update({ push_subscription: null })
                .eq('id', worker.id)
            }
          }
        }
      }
    }

      return new Response(
        JSON.stringify({
          message: `Notifications sent to ${successCount} of ${workers.length} workers`,
          notified: successCount,
          total: workers.length,
          push_notifications: pushCount
        }),
        { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
  } catch (error) {
    console.error('Error in send-shift-notifications function:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
