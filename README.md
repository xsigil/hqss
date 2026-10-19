# Hybrid QR Secret Sharing (HQSS) Monograph

[English](#overview) | [日本語](#概要)

A technical monograph and reference implementation of the **Hybrid QR Secret Sharing v4 (HQSS-v4)** architecture — an information-theoretic, disaster-resilient cold-storage key escrow protocol combining untrusted public cloud storage with ultra-low-density physical QR tokens.

---

## Overview

HQSS-v4 provides an unconditional information-theoretic key escrow scheme for critical cryptographic material (e.g., LUKS master keys, GnuPG private keys, master recovery seeds) without trusting public cloud providers.

### Key Pillars of HQSS-v4
- **Single-Tail Ephemeral Salt Masking:** Chunks $M_0 \sim M_8$ (90% of the AES-256 ciphertext) are aggregated and padded with a trailing CSPRNG random salt (0--4095 bytes). The cloud payload ($B_{\text{cloud}}$) is reduced to pure statistical white noise devoid of file signatures and OpenPGP tags.
- **Oracle Annihilation:** With the final 10% chunk ($M_9$) physically withheld, trial decryption oracles (padding verification, HMAC/GCM authentication tags) are mathematically eliminated, neutralizing brute-force and heuristic stripping attacks.
- **Ultra-Low-Density QR Tokens:** Salt entropy is discarded rather than retained. The physical core payload requires only $M_9$ and a 4-byte uint32 salt-length footer, resulting in ultra-low-density QR codes engineered specifically for fiber-laser deep engraving on precious metal plates (Silver 925 / SUS304).
- **Consolidated Shamir Thresholding (2-of-5):** Core payloads are dispersed using Shamir's Secret Sharing over $GF(2^8)$ via `gfsplit`/`gfcombine`. Any 2 surviving physical tokens can completely resurrect the master key offline.

---

## 概要

**Hybrid QR Secret Sharing v4 (HQSS-v4)** のアーキテクチャおよびプロトコル仕様をまとめた技術モノグラフとリファレンス実装です。信頼できないパブリッククラウドと、貴金属（シルバー925）やステンレスへの刻印に最適化した物理QRトークンを組み合わせることで、情報理論的安全性を満たすコールドバックアップを実現します。

### HQSS-v4 の中核アーキテクチャ
- **単一末尾ソルトマスキングと白色雑音化:** 暗号文の先頭90%（$M_0 \sim M_8$）を一括結合した末尾に $0 \sim 4095$ バイトのCSPRNG乱数ソルトを注入。クラウド保管データはファイルヘッダや統計的シグネチャを完全に喪失した白色雑音へ同化します。
- **復号判定オラクルの完全消滅:** 末尾10%（$M_9$）を物理世界へ隔離することでパディングや認証タグが失われ、クラウド全量押収時でも総当たり検証オラクルが数学的に成立しません。
- **ソルト実体破棄によるQR超低密度化:** 復元に必要な情報はソルトの「長さ（オフセット）」のみであるため、ソルト実体を手元に保持する仕様を撤廃。手元のコアペイロードは「$M_9$ ＋ 4バイトのLENGTHフッター」のみとなり、金属彫刻に耐えうる極小密度のQRコードを出力します。
- **多項式補間による災害耐性 (2-of-5):** コアペイロードをガロア体 $GF(2^8)$ 上のシャミア秘密分散（`gfsplit` / `gfcombine`）で5枚に分散。任意の2枚さえ回収できれば、火災や倒壊後でもオフライン環境で即座に鍵を再生できます。

---

## Building the Documents

The monograph is authored in LuaLaTeX and supports bilingual compilation (Japanese / English) from a single source tree.

### Prerequisites

- LuaLaTeX (`lualatex`)
- `latexmk`
- `libgfshare-bin` (`gfsplit`, `gfcombine`)
- `qrencode`
- Fonts: `Noto Serif`, `Noto Sans`, `Noto Sans Mono`, and `Noto Serif CJK JP`

### Build Targets

Build both language editions:
```bash
make all

```

Build language-specific editions:

```bash
make ja   # Builds build/hqss_ja.pdf
make en   # Builds build/hqss_en.pdf

```

Clean build artifacts:

```bash
make clean        # Removes intermediate files
make distclean    # Removes the build directory

```

---

## ライセンス / License

本プロジェクトは [MIT License](https://www.google.com/search?q=LICENSE) の下で公開されています。

MIT License

Copyright (c) 2026 Section 9 Inc.
[Physical Escrow Medium (Silver 925 / SUS304): https://monolith-id.com/]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
