# Very Good Flame Game

[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A Very Good Flame game created by Very Good Ventures 🦄.

Out of the box, Very Good Flame Game includes:

- ✅ Components - Think of them as game objects, or anything that can render in a game.
- ✅ Entity and Behaviors - Entities are what manage the game objects and the behaviors handle the game logic for those objects.
- ✅ Sprite Sheets - Easily access and render sprites on the screen.
- ✅ Audio - Background music and sound effects within the game.
- ✅ VGV Project Architecture - This project contains a similar architecture to other VGV projects (see our [core starter app](very_good_core_link)).
- ✅ 100% Test Coverage — Each line is executed at least once by a test.

_\* Learn more at [Generate a game foundation with our new template][very_good_flame_game_blog_link]_

## Output 📦

```sh
.
├── android
├── assets
│   ├── audio
│   ├── images
│   └── licenses
├── ios
├── lib
│   ├── app
│   ├── game
│   ├── gen
│   ├── l10n
│   ├── loading
│   └── title
├── test
├── web
├── windows
├── LICENSE
└── README.md
```

By default `mason make` will generate the output in the current working directory but a custom output directory can be specified via the [-o option][mason_output_dir]:

```sh
mason make very_good_flame_game -o ./output_folder
```

[mason_output_dir]: https://docs.brickhub.dev/mason-make#-custom-output-directory
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[very_good_core_link]: https://github.com/verygoodopensource/very_good_core
[very_good_flame_game_blog_link]: https://verygood.ventures/blog/generate-a-game-with-our-new-template
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link]: https://verygood.ventures
