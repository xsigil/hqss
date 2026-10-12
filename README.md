# Hybrid QR Secret Sharing (HQSS) Monograph

[English](#overview) | [日本語](#概要)

A technical monograph on the **Hybrid QR Secret Sharing (HQSS)** architecture — a disaster-resilient backup protocol combining public cloud hosting with split QR tokens.

---

## Overview

HQSS provides a cold-storage backup and recovery scheme for high-value secrets (e.g., GnuPG private keys, master recovery seeds) without trusting third-party cloud infrastructure.

- **Storage Optimization:** Large encrypted ciphertext blocks are split and hosted across arbitrary public endpoints (e.g., public Google Drive shares, IPFS, GitHub).
- **Physical Keys (QR):** Minimal decryption metadata, fetch URLs, and the final key fragment are compressed and encoded into physical QR codes.
- **Client-Side Recovery:** Scanning the QR codes loads the orchestrator locally (using URL hash fragments), fetches public fragments, and decrypts the secret entirely inside the browser/local environment without exposing keys to intermediate servers.

## Building the Documents

The monograph is authored in LuaLaTeX and supports bilingual compilation (Japanese / English) from a single source tree.

### Prerequisites

- LuaLaTeX (`lualatex`)
- `latexmk`
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

## 概要

**Hybrid QR Secret Sharing (HQSS)** のアーキテクチャおよびプロトコル仕様をまとめた技術モノグラフです。公開クラウドストレージと分割QRコードを組み合わせることで、可用性と秘匿性を両立したコールドバックアップを実現します。

* **大容量外部メモリとしてのクラウド:** 暗号化された大半のデータ断片は、任意のパブリックストレージ（Google Drive公開リンク、IPFS等）に分散ホスト。
* **物理解錠キーとしてのQRコード:** クラウド上の断片を取得するためのURL群と、最後の復号キー（Base64断片）のみをコンパクトにQRコード化。
* **ゼロ知識ブラウザ復元:** URLハッシュフラグメント（`#`）を活用し、外部サーバーに鍵情報を一切渡さずローカル環境（ブラウザ内）で断片の回収・結合・復号を完結。

## ライセンス

See the repository header or source headers for copyright and usage terms.
