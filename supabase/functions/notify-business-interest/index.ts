// Supabase Edge Function: Send email notifications to businesses when workers express interest
// This function is triggered when a worker expresses interest in a shift

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')
const FROM_EMAIL = Deno.env.get('FROM_EMAIL') || 'notifications@lastcallwork.com'

interface Interest {
  id: string
  shift_id: string
  worker_id: string
  status?: string
}

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
  email: string
  business_name: string
  email_notifications_enabled: boolean
}

interface Worker {
  id: string
  email: string
  full_name: string
  phone?: string
  years_experience?: number
  positions?: string[]
  certifications?: string[]
}

serve(async (req) => {
  try {
    // Get the interest data from the request
    const { interest, shift, worker } = await req.json() as { 
      interest: Interest; 
      shift: Shift; 
      worker: Worker 
    }

    if (!interest || !shift || !worker) {
      return new Response(
        JSON.stringify({ error: 'Missing interest, shift, or worker data' }),
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // Initialize Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Get business information
    const { data: business, error: businessError } = await supabase
      .from('businesses')
      .select('id, email, business_name, email_notifications_enabled')
      .eq('id', shift.business_id)
      .single()

    if (businessError || !business) {
      console.error('Error fetching business:', businessError)
      return new Response(
        JSON.stringify({ error: 'Failed to fetch business' }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // Check if business has email notifications enabled
    if (!business.email_notifications_enabled) {
      return new Response(
        JSON.stringify({ message: 'Business has email notifications disabled', notified: false }),
        { status: 200, headers: { 'Content-Type': 'application/json' } }
      )
    }

    // Check if business has an email address
    if (!business.email) {
      return new Response(
        JSON.stringify({ message: 'Business has no email address', notified: false }),
        { status: 200, headers: { 'Content-Type': 'application/json' } }
      )
    }

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

    // Build worker info
    const workerInfo = [
      worker.full_name,
      worker.years_experience ? `${worker.years_experience} years experience` : null,
      worker.positions && worker.positions.length > 0 ? `Positions: ${worker.positions.join(', ')}` : null,
      worker.certifications && worker.certifications.length > 0 ? `Certifications: ${worker.certifications.join(', ')}` : null,
      worker.phone ? `Phone: ${worker.phone}` : null
    ].filter(Boolean).join(' • ')

    // Send email to business
    const emailBody = `
      <!DOCTYPE html>
      <html>
      <head>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: #1e293b; color: white; padding: 20px; border-radius: 8px 8px 0 0; }
          .content { background: #f8f9fa; padding: 20px; border-radius: 0 0 8px 8px; }
          .shift-details { background: white; padding: 15px; margin: 15px 0; border-radius: 4px; border-left: 4px solid #10b981; }
          .worker-details { background: white; padding: 15px; margin: 15px 0; border-radius: 4px; border-left: 4px solid #3b82f6; }
          .button { display: inline-block; background: #3b82f6; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; margin-top: 15px; }
          .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>👤 New Worker Interest on LastCall!</h1>
          </div>
          <div class="content">
            <p>Hi ${business.business_name},</p>
            <p>A worker has expressed interest in one of your shifts!</p>
            
            <div class="shift-details">
              <h3>Shift Details</h3>
              <p><strong>Position:</strong> ${shift.position}</p>
              <p><strong>Date:</strong> ${shiftDate}</p>
              <p><strong>Time:</strong> ${startTime} - ${endTime}</p>
              <p><strong>Pay:</strong> ${payInfo}</p>
              ${shift.notes ? `<p><strong>Notes:</strong> ${shift.notes}</p>` : ''}
            </div>
            
            <div class="worker-details">
              <h3>Interested Worker</h3>
              <p><strong>Name:</strong> ${worker.full_name}</p>
              ${workerInfo ? `<p>${workerInfo}</p>` : ''}
              ${worker.email ? `<p><strong>Email:</strong> ${worker.email}</p>` : ''}
            </div>
            
            <a href="https://lastcallwork.com" class="button">View on LastCall</a>
            
            <p style="margin-top: 20px; font-size: 14px; color: #666;">
              Log in to your LastCall dashboard to review and accept or reject this worker.
            </p>
          </div>
          <div class="footer">
            <p>You're receiving this because you have email notifications enabled.</p>
            <p>Manage your notification preferences in your LastCall business settings.</p>
          </div>
        </div>
      </body>
      </html>
    `

    // Use Resend API to send email
    if (!RESEND_API_KEY) {
      console.error('RESEND_API_KEY not configured')
      return new Response(
        JSON.stringify({ error: 'Email service not configured' }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
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
          to: business.email,
          subject: `New Worker Interest - ${shift.position} Shift on ${shiftDate}`,
          html: emailBody
        })
      })

      if (!resendResponse.ok) {
        const errorData = await resendResponse.text()
        console.error(`Failed to send email to ${business.email}:`, errorData)
        return new Response(
          JSON.stringify({ error: 'Failed to send email', details: errorData }),
          { status: 500, headers: { 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({
          message: 'Notification sent successfully',
          notified: true,
          business_email: business.email
        }),
        { status: 200, headers: { 'Content-Type': 'application/json' } }
      )
    } catch (error) {
      console.error(`Error sending email to ${business.email}:`, error)
      return new Response(
        JSON.stringify({ error: error.message }),
        { status: 500, headers: { 'Content-Type': 'application/json' } }
      )
    }
  } catch (error) {
    console.error('Error in notify-business-interest function:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    )
  }
})
