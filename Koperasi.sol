// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Koperasi Simpan Pinjam Terdesentralisasi
 * @dev Mengatur otomatisasi Simpanan Pokok, Simpanan Wajib, dan kalkulasi angka desimal.
 */
contract KoperasiSimpanPinjam {
    address public pengurus;
    
    // Ketetapan tarif Simpanan Pokok dalam satuan Gwei (10000 Gwei)
    uint256 public constant SIMPANAN_POKOK = 10000; 
    
    struct Anggota {
        bool statusAktif;
        uint256 simpananPokok;
        uint256 simpananWajib;
    }

    mapping(address => Anggota) public dataAnggota;

    event AnggotaBaru(address indexed akunAnggota);
    event SetoranMasuk(address indexed akunAnggota, uint256 jumlahDana, string jenisSimpanan);

    modifier hanyaPengurus() {
        require(msg.sender == pengurus, "Akses ditolak: Hanya Pengurus yang diizinkan");
        _;
    }

    modifier hanyaAnggota() {
        require(dataAnggota[msg.sender].statusAktif, "Akses ditolak: Akun Anda tidak aktif");
        _;
    }

    constructor() {
        pengurus = msg.sender;
    }

    /**
     * @notice Fungsi untuk mendaftar menjadi anggota koperasi
     * @dev Calon anggota wajib mengirimkan dana pas sesuai nominal SIMPANAN_POKOK
     */
    function daftarAnggota() external payable {
        require(!dataAnggota[msg.sender].statusAktif, "Akun sudah terdaftar");
        require(msg.value == SIMPANAN_POKOK, "Nominal dana harus sesuai dengan Simpanan Pokok");

        dataAnggota[msg.sender] = Anggota({
            statusAktif: true,
            simpananPokok: msg.value,
            simpananWajib: 0
        });

        emit AnggotaBaru(msg.sender);
        emit SetoranMasuk(msg.sender, msg.value, "Pokok");
    }

    /**
     * @notice Fungsi bagi anggota aktif untuk menyetor simpanan wajib berkala
     */
    function bayarSimpananWajib() external payable hanyaAnggota {
        require(msg.value > 0, "Nominal setoran tidak boleh nol");
        
        dataAnggota[msg.sender].simpananWajib += msg.value;
        emit SetoranMasuk(msg.sender, msg.value, "Wajib");
    }

    /**
     * @notice Simulasi perhitungan bunga dengan pendekatan matematika fixed-point.
     * @dev Karena Solidity tidak mendukung tipe data float/desimal secara native,
     * angka dimasukkan dalam bentuk integer berbasis ratusan (scaled integer).
     * Contoh: Input 202 mewakili 2.02. Hasil kuadratnya adalah 40804, yang secara 
     * logika UI off-chain akan diterjemahkan kembali menjadi 4.0804.
     */
    function hitungSimulasiBunga(uint256 rateBerbasisRatusan) public pure returns (uint256) {
        uint256 hasilPerhitungan = rateBerbasisRatusan * rateBerbasisRatusan;
        return hasilPerhitungan;
    }
}
