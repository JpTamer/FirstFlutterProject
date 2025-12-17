'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "bab61b833473f2d2bffd5881e4ae6d8e",
"version.json": "6d10a1f8da6b148b2e462f7090e4590b",
"index.html": "71d1cd8267ae879e681cad7d4ff49785",
"/": "71d1cd8267ae879e681cad7d4ff49785",
"main.dart.js": "1a30830954d064fbdb01f04981d0bc29",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "2602f795250ac6ad7a76a42910f41ee0",
"assets/NOTICES": "2fe2247f8c2947c999032ea21294baaa",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "9815ca83d710039d35f57da5ed0d178c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/AssetManifest.bin": "a46cc6fa4dc8497d43b8b6eb8f1a355a",
"assets/fonts/MaterialIcons-Regular.otf": "cb1262fc01037fb35b47ebad50803a63",
"assets/assets/images/pomegranateFruitRot.jpg": "e1ab1fbc30af0da642e7de5f88b9ee3c",
"assets/assets/images/card.png": "6a0c0852c5730e04adc3c8fc00137cb1",
"assets/assets/images/mangoPowderyMildew.jpg": "525596c33096bbddf64cb79f39a923b1",
"assets/assets/images/almondBrownRot.jpg": "e7f76c93165d772834cb7b53344de852",
"assets/assets/images/coffeeLeafRust.jpg": "48557cb05933801ae779fb43bfcf44f6",
"assets/assets/images/peachLeafCurl.jpg": "00884847c5cc72f4cd06edde23597231",
"assets/assets/images/apple-scab.jpg": "1d550ba4fd723e6b2acf9a35711838ee",
"assets/assets/images/dark.png": "165525d81d6bf6e1fb0285588d6d4358",
"assets/assets/images/rootRot.png": "9c025e6f4b5de41707fe81f5ea5ce7fb",
"assets/assets/images/coffeeBerryDisease.jpg": "cf1f8f53e2275ec417d01e5e028d9b87",
"assets/assets/images/downyMildew.jpg": "51507bac6733ab45f623a07dae944e2c",
"assets/assets/images/avocadoAnthracnose.jpg": "8ef3991666ec600ed53811a7239c73fb",
"assets/assets/images/blackSigatoka.jpg": "398ee302f3311215aaf16faac6043f40",
"assets/assets/images/brownRot.jpg": "95e5acc6d562bf33318f263c9e73a184",
"assets/assets/images/anthracnose.jpg": "96556604c7d3220063fdf9b3078d6940",
"assets/assets/images/lethalYellowing.jpg": "97a25d6b67441f5cdf6111f918942f46",
"assets/assets/images/aphids.jpg": "ae6f8fbe99c8b1f8392340091f3776ab",
"assets/assets/images/ganodermaButtRot.jpg": "2ddcf47c395bc447ddca3423a6013dc6",
"assets/assets/images/grapePowderyMildew.jpg": "8539f33c147cf9c23811d570c9287927",
"assets/assets/images/search.png": "a38415990de420b3e46d73da44151ede",
"assets/assets/images/light.png": "72a7ad6ef4cd478ea81663cbd9084876",
"assets/assets/images/cherryPowderyMildew.jpg": "d885b5e9a78884af2f4057bcce4bcd71",
"assets/assets/images/needleCast.jpg": "ccfa8e13fec398006ed2edb4d718f098",
"assets/assets/images/lateBlight.jpg": "8232f2b42e7d3972d7122b3e4ae187bc",
"assets/assets/images/shotHoleDisease.jpg": "3c8adb52062f719c0c9dbfb2bb7477bb",
"assets/assets/images/Logo.png": "59c4bd948952401c52e0cb3dee0a34da",
"assets/assets/images/pomegranateLeafSpot.jpg": "0f8db2829ec2242dd658564f8db4358c",
"assets/assets/images/avocadoRootRot.jpg": "0fc0fa65aa44b76d2463f4b1df5fe5bc",
"assets/assets/images/pineWilt.jpg": "cd64fca619faee12abc25a68ec681156",
"assets/assets/images/leafSpot.webp": "6f56844b4bf699c8c71c21afd0cf514d",
"assets/assets/images/open.png": "a411ed9964f6447ef5c4749ad6c876fa",
"assets/assets/images/panamaDisease.jpg": "4fe5aa53f372913f0d64ce9730899ac5",
"assets/assets/images/powderyMildew.jpg": "97c1dce66accdcd847fbd76d0396b8e6",
"assets/assets/images/earlyBlight.jpg": "254123103089c1d32343a41c99221545",
"assets/assets/images/peachBrownRot.jpg": "2f014b5b7f6163640c225d773e798dca",
"assets/assets/images/citrusCanker.jpg": "1c945fd243ae450c091eaf81d8f99949",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01"};
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
