"use strict";
{{=<% %>=}}{{flutter_js}}<%={{ }}=%>
{{=<% %>=}}{{flutter_build_config}}<%={{ }}=%>

const progressText = document.querySelector('#progress-text');
const progressIndicator = document.querySelector('#progress-indicator');

async function readAssets() {
  // AssetManifest.bin is encoded with Flutter's Standard Message Codec.
  // See: https://docs.flutter.dev/platform-integration/web/initialization
  // See also: https://docs.flutter.dev/release/breaking-changes/asset-manifest-dot-json#reading-asset-manifest-information-from-dart-code-outside-of-a-flutter-app
  // Keep in mind that AssetManifest.bin is an implementation detail of Flutter.
  // Reading this file isn't an officially supported workflow. The contents or format of the file might change in a future Flutter release without an announcement.
  const response = await fetch('assets/AssetManifest.bin');
  const buffer = await response.arrayBuffer();
  const view = new DataView(buffer);
  let o = 0;

  const readByte = () => view.getUint8(o++);
  const readSize = () => {
    const b = readByte();
    if (b < 254) return b;
    if (b === 254) { const s = view.getUint16(o, true); o += 2; return s; }
    const s = view.getUint32(o, true); o += 4; return s;
  };
  const readString = () => {
    const n = readSize();
    const s = new TextDecoder().decode(new Uint8Array(buffer, o, n));
    o += n;
    return s;
  };
  const skip = () => {
    const t = readByte();
    if (t <= 2) return;
    if (t === 7 || t === 8) { const n = readSize(); o += n; return; }
    if (t === 12) { for (let i = readSize(); i > 0; i--) skip(); return; }
    if (t === 13) { for (let i = readSize() * 2; i > 0; i--) skip(); }
  };

  // The manifest is a map; we only need its keys (the asset paths).
  readByte(); // type 13 (map)
  const count = readSize();
  const assets = [];
  for (let i = 0; i < count; i++) {
    readByte(); // type 7 (string)
    const path = readString();
    if (!path.startsWith('packages/')) assets.push(path);
    skip();
  }
  return assets;
}

let loadedAssets = 0;
let totalAssets;

async function beginPreloading() {
  const assets = await readAssets();

  totalAssets = assets.length;
  if (totalAssets === 0) {
    // No assets to load, so we can skip the loading process entirely.
    return;
  }

  const batchSize = 20;

  progressIndicator.style.width = '0%';
  progressText.textContent = `Loaded ${loadedAssets} of ${totalAssets} assets`;

  for (let i = 0; i < assets.length; i += batchSize) {
    const batch = assets.slice(i, i + batchSize);
    await loadBatch(batch);
  }
}

function reportProgress() {
  loadedAssets++;

  const value = Math.floor((loadedAssets / totalAssets) * 100) + '%';
  progressIndicator.style.width = value;

  progressText.textContent = `Loaded ${loadedAssets} of ${totalAssets} assets`;
}

async function load(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(
        `Failed to load: ${response.status} ${response.statusText}`,
      );
    }
    return await response.text();
  } catch (error) {
    throw new Error("Network error");
  }
}

async function loadBatch(urls) {
  const loadPromises = urls.map(async (url) => {
    await load(url);
    reportProgress();
  });
  try {
    return await Promise.all(loadPromises);
  } catch (error) {
    console.error('Error loading one or more asset:', error);
  }
}

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    await Promise.all([
      beginPreloading(),
      engineInitializer.initializeEngine(),
    ]).then(([_, appRunner]) => appRunner.runApp());
  }
});
