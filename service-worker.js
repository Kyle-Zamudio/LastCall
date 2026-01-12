// Service Worker for LastCall Push Notifications
// This enables notifications even when the browser is closed

const CACHE_NAME = 'lastcall-v1';
const urlsToCache = [
  '/',
  '/index.html'
];

// Install Service Worker
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Service Worker: Cache opened');
        return cache.addAll(urlsToCache);
      })
      .catch((err) => {
        console.log('Service Worker: Cache failed', err);
      })
  );
  self.skipWaiting(); // Activate immediately
});

// Activate Service Worker
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            console.log('Service Worker: Removing old cache', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  return self.clients.claim(); // Take control of all pages immediately
});

// Handle push notifications
self.addEventListener('push', (event) => {
  console.log('Service Worker: Push event received', event);
  
  let notificationData = {
    title: 'LastCall',
    body: 'You have a new notification',
    icon: '/icon-192x192.png', // You can add an icon later
    badge: '/badge-72x72.png',
    tag: 'lastcall-notification',
    requireInteraction: false,
    vibrate: [200, 100, 200], // Vibration pattern for mobile
    data: {
      url: '/'
    }
  };

  // If we have notification data from the push event, use it
  if (event.data) {
    try {
      const data = event.data.json();
      notificationData = {
        ...notificationData,
        ...data
      };
    } catch (e) {
      // If not JSON, try text
      const text = event.data.text();
      if (text) {
        notificationData.body = text;
      }
    }
  }

  event.waitUntil(
    self.registration.showNotification(notificationData.title, {
      body: notificationData.body,
      icon: notificationData.icon || '/icon-192x192.png',
      badge: notificationData.badge || '/badge-72x72.png',
      tag: notificationData.tag,
      requireInteraction: notificationData.requireInteraction,
      vibrate: notificationData.vibrate,
      data: notificationData.data,
      actions: notificationData.actions || []
    })
  );
});

// Handle notification clicks
self.addEventListener('notificationclick', (event) => {
  console.log('Service Worker: Notification clicked', event);
  
  event.notification.close();

  const urlToOpen = event.notification.data?.url || '/';

  event.waitUntil(
    clients.matchAll({
      type: 'window',
      includeUncontrolled: true
    }).then((clientList) => {
      // Check if there's already a window open
      for (let i = 0; i < clientList.length; i++) {
        const client = clientList[i];
        if (client.url === urlToOpen && 'focus' in client) {
          return client.focus();
        }
      }
      // If no window is open, open a new one
      if (clients.openWindow) {
        return clients.openWindow(urlToOpen);
      }
    })
  );
});

// Handle messages from the main app
self.addEventListener('message', (event) => {
  console.log('Service Worker: Message received', event.data);
  
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
  
  if (event.data && event.data.type === 'SHOW_NOTIFICATION') {
    const { title, body, icon, tag, data } = event.data;
    event.waitUntil(
      self.registration.showNotification(title, {
        body,
        icon: icon || '/icon-192x192.png',
        badge: '/badge-72x72.png',
        tag: tag || 'lastcall-notification',
        vibrate: [200, 100, 200],
        data: data || { url: '/' }
      })
    );
  }
});

// Fetch event (for offline support)
self.addEventListener('fetch', (event) => {
  // We can add offline caching here if needed
  // For now, just let requests go through normally
});
