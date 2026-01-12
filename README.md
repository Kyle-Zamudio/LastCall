# LastCall

A platform connecting restaurants and hospitality businesses with available workers for shift coverage.

## Features

- **For Workers**: Browse and apply for shifts matching your skills and availability
- **For Businesses**: Post shifts and find qualified workers quickly
- **Email Notifications**: Get notified when new shifts are posted or when workers express interest
- **Real-time Updates**: Browser notifications for instant alerts

## Tech Stack

- Frontend: React (via Babel), Tailwind CSS
- Backend: Supabase (PostgreSQL, Edge Functions)
- Email: Resend API
- Hosting: GitHub Pages (via CNAME)

## Setup

### Prerequisites

- Supabase account and project
- Resend API key for email notifications
- Supabase CLI (for deploying Edge Functions)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Kyle-Zamudio/LastCall.git
   cd LastCall
   ```

2. Set up Supabase:
   - Link your project: `supabase link --project-ref your-project-ref`
   - Set secrets: `supabase secrets set RESEND_API_KEY=your_key`
   - Deploy Edge Functions: `supabase functions deploy send-shift-notifications`

3. Run database migrations:
   - See `migration_*.sql` files in the root directory
   - Run them in order in your Supabase SQL Editor

### Email Notifications

Email notifications are handled by Supabase Edge Functions:
- `send-shift-notifications`: Notifies workers when new shifts are posted
- `notify-business-interest`: Notifies businesses when workers express interest

See `NOTIFICATION_SETUP.md` for detailed setup instructions.

## Project Structure

```
LastCall/
├── index.html                 # Main application file
├── supabase/
│   └── functions/            # Supabase Edge Functions
│       ├── send-shift-notifications/
│       └── notify-business-interest/
├── migration_*.sql            # Database migrations
└── *.md                       # Documentation files
```

## Development

The application is a single-page React application served via `index.html`. No build process required - just open `index.html` in a browser or serve it via a web server.

## License

[Add your license here]

## Contact

For support, email: lastcallwork@gmail.com
