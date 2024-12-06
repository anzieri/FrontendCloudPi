'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e52a51c4a0d9c8662730d2a1f43933f1",
"assets/AssetManifest.bin.json": "53f3a93e9288466617aee8783a94a9c1",
"assets/AssetManifest.json": "2912dacb244b92af01c70a3fd32a520e",
"assets/assets/fonts/Lexend-Black.ttf": "fe567612263deb865b5622076c8c8410",
"assets/assets/fonts/Lexend-Bold.ttf": "4d5d99a2bed14c4c23950731cf6412a2",
"assets/assets/fonts/Lexend-ExtraBold.ttf": "ba879a9bb89a7bb54e3e356b059ad1f3",
"assets/assets/fonts/Lexend-ExtraLight.ttf": "0be2b26365f29b5ef8fecac1a72fb852",
"assets/assets/fonts/Lexend-Light.ttf": "f5f37cf9f05f51ab6caf78712fa17fc5",
"assets/assets/fonts/Lexend-Medium.ttf": "8d7edc33c0dc0daaabd638f21bcdf8fb",
"assets/assets/fonts/Lexend-Regular.ttf": "c0dc51d28f78a1d929e777bbfdb514cb",
"assets/assets/fonts/Lexend-SemiBold.ttf": "9db9d801f0cb8ce3f0ddb04565ff3bd8",
"assets/assets/fonts/Lexend-Thin.ttf": "fd8db6b3171888aaa06d4fdacb2c83d1",
"assets/assets/fonts/Lexend-VariableFont_wght.ttf": "a5144e9ee41f343224a9efc3efcbf1bc",
"assets/assets/fonts/OpenSans-Bold.ttf": "5112859ee40a5dfa527b3b4068ccd74d",
"assets/assets/fonts/OpenSans-ExtraBold.ttf": "9653672b9552d4e42cebc073f0231368",
"assets/assets/fonts/OpenSans-Italic.ttf": "dac22be0d4aaa6e9f6ce8204be7fe2c9",
"assets/assets/fonts/OpenSans-Light.ttf": "67090f15e31c78e9d1da28225cc08b24",
"assets/assets/fonts/OpenSans-LightItalic.ttf": "973ce415d2d09ac64931de57471c5bca",
"assets/assets/fonts/OpenSans-Medium.ttf": "3df8f041f884b3fd7e14c8fd4c3d9a1d",
"assets/assets/fonts/OpenSans-Regular.ttf": "7df68ccfcb8ffe00669871052a4929c9",
"assets/assets/fonts/OpenSans-SemiBold.ttf": "58fb53a79ecf1314a1f38bceb8b2a992",
"assets/assets/fonts/Open_Sans.ttf": "95393d9faf957406807a05d8fba3f4fc",
"assets/assets/fonts/Poppins-Black.ttf": "14d00dab1f6802e787183ecab5cce85e",
"assets/assets/fonts/Poppins-Bold.ttf": "08c20a487911694291bd8c5de41315ad",
"assets/assets/fonts/Poppins-ExtraBold.ttf": "d45bdbc2d4a98c1ecb17821a1dbbd3a4",
"assets/assets/fonts/Poppins-ExtraLight.ttf": "6f8391bbdaeaa540388796c858dfd8ca",
"assets/assets/fonts/Poppins-Italic.ttf": "c1034239929f4651cc17d09ed3a28c69",
"assets/assets/fonts/Poppins-Light.ttf": "fcc40ae9a542d001971e53eaed948410",
"assets/assets/fonts/Poppins-Medium.ttf": "bf59c687bc6d3a70204d3944082c5cc0",
"assets/assets/fonts/Poppins-Regular.ttf": "093ee89be9ede30383f39a899c485a82",
"assets/assets/fonts/Poppins-SemiBold.ttf": "6f1520d107205975713ba09df778f93f",
"assets/assets/fonts/Poppins-Thin.ttf": "9ec263601ee3fcd71763941207c9ad0d",
"assets/assets/pics/Cloud.png": "10789ecc9bbdf6472f5ae345d9313465",
"assets/assets/pics/filledpi.png": "7f260e17522ed5217f5e17d5fb8dec6a",
"assets/assets/pics/fixedpi.png": "56157d171ca57213f8b81674ddabe94e",
"assets/assets/pics/home.png": "56f8205850dc6a2e92c791a67e91da6f",
"assets/FontManifest.json": "810d764fc66c9cfbe92fb13eb0883cd0",
"assets/fonts/MaterialIcons-Regular.otf": "f951473d4d9339d9425f75b32a040082",
"assets/NOTICES": "629ce07d09780263fb3c5947631382e5",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.js.symbols": "0e55ae2b91bdaac8f973a6485332bdc6",
"canvaskit/canvaskit.wasm": "8f4f2effe0bac7b5e3c43a7f9ea47275",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.js.symbols": "43bfedc93b83230802587d761d768b0e",
"canvaskit/chromium/canvaskit.wasm": "6cc6af0656608b5b904bc4ac877f4612",
"canvaskit/skwasm.js": "f17a293d422e2c0b3a04962e68236cc2",
"canvaskit/skwasm.js.symbols": "2a991bf1c6d7aded68faeb3edf13b82f",
"canvaskit/skwasm.wasm": "c718043c08c005ababa7c89c465f69c8",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"flutter_bootstrap.js": "564ae892ce9d93fb67e6dbce74a9d5ae",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2e9e16a8fb63ff294f5544e1b4b44e17",
"/": "2e9e16a8fb63ff294f5544e1b4b44e17",
"main.dart.js": "8ac1d36b8ec4897f8caecd410d6482dd",
"manifest.json": "5182bc1d7cd911c8ab07be39a87c4c58",
"version.json": "d4f3ea84ddd083ed0c9896b2a30ac028"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
