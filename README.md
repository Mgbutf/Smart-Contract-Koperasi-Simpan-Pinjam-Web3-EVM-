# Smart-Contract-Koperasi-Simpan-Pinjam-Web3-EVM-
Proyek ini dirancang berdasarkan struktur tata kelola UU No. 25 Tahun 1992, memisahkan instrumen permodalan menjadi Simpanan Pokok dan Simpanan Wajib.

# Decentralized Koperasi Simpan Pinjam (Web3 / EVM)

Sistem smart contract terdesentralisasi untuk manajemen tata kelola keuangan koperasi simpan pinjam berbasis blockchain. Kontrak ini mengotomatisasi pencatatan keanggotaan dan pemisahan instrumen permodalan secara on-chain.

## 🔑 Fitur Utama

- **Dual-Tier Deposit System**: Memisahkan logika keuangan antara Simpanan Pokok (pembayaran sekali di awal untuk registrasi) dan Simpanan Wajib (setoran rutin keanggotaan).
- **Fixed-Point Arithmetic Scaling**: Mengimplementasikan perhitungan perkalian desimal presisi tinggi pada jaringan EVM yang tidak mendukung native floating-point (contoh: memproses angka basis `202` untuk merepresentasikan `2.02`, menghasilkan kalkulasi `40804` yang dibaca sebagai `4.0804`).
- **Transparansi Dana**: Seluruh riwayat setoran terekam secara permanen di dalam blockchain melalui sistem Event Log.

## 🛠️ Tech Stack

- **Bahasa Pemrograman**: Solidity ^0.8.19
- **Lingkungan Pengembangan**: EVM Compatible (Siap di-deploy ke Holesky Testnet)
