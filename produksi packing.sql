-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: sql103.infinityfree.com
-- Waktu pembuatan: 10 Sep 2026 pada 04.02
-- Versi server: 11.4.13-MariaDB
-- Versi PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `if0_42879599_db_produksi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `checklist_wrapping`
--

CREATE TABLE `checklist_wrapping` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `source_type` enum('fg','wip') NOT NULL DEFAULT 'fg',
  `tanggal` date DEFAULT NULL,
  `shift_regu` varchar(150) DEFAULT NULL,
  `operator` varchar(150) DEFAULT NULL,
  `no_urut` int(11) NOT NULL,
  `no_pallet` varchar(30) DEFAULT NULL,
  `lokal_ekspor` varchar(10) DEFAULT NULL,
  `jenis_packing` varchar(20) DEFAULT NULL,
  `jam` varchar(50) DEFAULT NULL,
  `jumlah_pallet` varchar(30) DEFAULT NULL,
  `jumlah_karton` varchar(30) DEFAULT NULL,
  `kodefikasi` varchar(150) DEFAULT NULL COMMENT 'Gabungan PROD / EXP / TGR',
  `status` varchar(20) DEFAULT NULL COMMENT 'Auto: RELEASE kalau salah satu output cell terisi',
  `keterangan` varchar(255) DEFAULT NULL COMMENT 'Auto: "No Palet X" atau "No Palet X-Y"',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Baris Checklist Hasil Wrapping, bisa dihapus per baris';

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil_produksi`
--

CREATE TABLE `hasil_produksi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date DEFAULT NULL,
  `no_urut` int(11) NOT NULL,
  `sku` varchar(30) DEFAULT NULL,
  `nama_produk` varchar(255) DEFAULT NULL COMMENT 'Auto-fill dari SKU kalau diisi',
  `planning` decimal(14,2) DEFAULT NULL,
  `actual` decimal(14,2) DEFAULT NULL,
  `presentase` decimal(6,1) DEFAULT NULL COMMENT 'Computed: actual/planning*100',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tabel Hasil Produksi (SKU, Nama, Planning, Actual, Presentase)';

-- --------------------------------------------------------

--
-- Struktur dari tabel `identitas_fg`
--

CREATE TABLE `identitas_fg` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_barang` varchar(30) DEFAULT NULL COMMENT 'FK longgar ke master_barang_fg.kode',
  `nama_barang` varchar(255) DEFAULT NULL,
  `buyer` varchar(150) DEFAULT NULL,
  `line` varchar(30) DEFAULT NULL,
  `regu` varchar(150) DEFAULT NULL,
  `shift` char(1) DEFAULT NULL,
  `jenis_produk` varchar(20) DEFAULT NULL COMMENT 'EKSPOR/LOKAL',
  `jenis_packing` varchar(20) DEFAULT NULL COMMENT 'HCO/RENCENG',
  `lokal_ekspor` varchar(10) DEFAULT NULL,
  `std_per_jam` decimal(12,2) DEFAULT NULL,
  `jalan_mesin` varchar(30) DEFAULT NULL,
  `jam_kerja` varchar(30) DEFAULT NULL,
  `jumlah_karton` varchar(30) DEFAULT NULL,
  `jumlah_palet` varchar(30) DEFAULT NULL,
  `tanggal_produksi` date DEFAULT NULL,
  `kode_tgr` varchar(50) DEFAULT NULL COMMENT 'Hasil generate kode TGR (disimpan sbg cache)',
  `kode_prod` varchar(50) DEFAULT NULL,
  `kode_exp` varchar(50) DEFAULT NULL,
  `dibuat_oleh` varchar(150) DEFAULT NULL,
  `diverifikasi_oleh` varchar(150) DEFAULT NULL,
  `diketahui_oleh` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Header Form Identitas FG';

-- --------------------------------------------------------

--
-- Struktur dari tabel `identitas_wip`
--

CREATE TABLE `identitas_wip` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_barang` varchar(30) DEFAULT NULL COMMENT 'FK longgar ke master_barang_wip.kode',
  `nama_produk` varchar(255) DEFAULT NULL,
  `buyer` varchar(150) DEFAULT NULL,
  `line` varchar(30) DEFAULT NULL COMMENT 'Kalau "wip" -> line_digit_tgr dipaksa 4',
  `regu` varchar(150) DEFAULT NULL,
  `shift` char(1) DEFAULT NULL,
  `jenis_produk` varchar(20) DEFAULT NULL,
  `jenis_packing` varchar(20) DEFAULT NULL,
  `lokal_ekspor` varchar(10) DEFAULT NULL,
  `std_per_jam` decimal(12,2) DEFAULT NULL,
  `jalan_mesin` varchar(30) DEFAULT NULL,
  `jam_kerja` varchar(30) DEFAULT NULL,
  `hasil_karton` varchar(30) DEFAULT NULL,
  `hasil_palet` varchar(30) DEFAULT NULL,
  `tanggal_produksi` date DEFAULT NULL,
  `kode_tgr` varchar(50) DEFAULT NULL,
  `kode_prod` varchar(50) DEFAULT NULL,
  `kode_exp` varchar(50) DEFAULT NULL,
  `dibuat_oleh` varchar(150) DEFAULT NULL,
  `diverifikasi_oleh` varchar(150) DEFAULT NULL,
  `diketahui_oleh` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Header Form Identitas WIP';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_barang_fg`
--

CREATE TABLE `master_barang_fg` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode` varchar(30) NOT NULL COMMENT 'SKU / Kode Barang',
  `nama` varchar(255) NOT NULL COMMENT 'Nama Barang (ukuran masih menyatu di sini)',
  `buyer` varchar(150) DEFAULT NULL,
  `jenis_produk` varchar(20) DEFAULT NULL COMMENT 'EKSPOR / LOKAL',
  `jenis_packing` varchar(20) DEFAULT NULL COMMENT 'HCO / RENCENG / BULKY',
  `std_per_jam` decimal(12,2) DEFAULT NULL,
  `karton` varchar(30) DEFAULT NULL,
  `karton_palet` varchar(30) DEFAULT NULL,
  `jumlah_palet` decimal(12,2) DEFAULT NULL,
  `jalan_mesin` varchar(30) DEFAULT NULL,
  `jam_kerja` varchar(30) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `shift` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Master data barang FG (1 SKU bisa >1 baris kalau buyer beda)';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_barang_wip`
--

CREATE TABLE `master_barang_wip` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode` varchar(30) NOT NULL COMMENT 'SKU / Kode Barang',
  `nama` varchar(255) NOT NULL COMMENT 'Nama Produk',
  `buyer` varchar(150) DEFAULT NULL,
  `isi_per_pallet` varchar(50) DEFAULT NULL,
  `std_per_jam` decimal(12,2) DEFAULT NULL,
  `jalan_mesin` varchar(30) DEFAULT NULL,
  `jam_kerja` varchar(30) DEFAULT NULL,
  `hasil_karton` varchar(30) DEFAULT NULL,
  `hasil_palet` varchar(30) DEFAULT NULL,
  `jenis_produk` varchar(20) DEFAULT NULL,
  `jenis_packing` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Master data barang WIP';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_buyer`
--

CREATE TABLE `master_buyer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_buyer` varchar(150) NOT NULL,
  `kode_buyer` varchar(5) DEFAULT NULL COMMENT '3 digit, dipakai di kode TGR',
  `negara` varchar(50) DEFAULT NULL COMMENT 'Untuk suffix TGR: VN/TH/CB',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Master buyer untuk lookup kode TGR';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_kodefikasi_buyer`
--

CREATE TABLE `master_kodefikasi_buyer` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sku` varchar(30) NOT NULL,
  `buyer` varchar(150) NOT NULL,
  `nama_produk` varchar(255) DEFAULT NULL COMMENT 'Opsional: cache nama produk',
  `ukuran` varchar(100) DEFAULT NULL COMMENT 'Contoh: 12x20x25g',
  `format_prod` varchar(50) NOT NULL COMMENT 'Pola tanggal PROD, misal DD/MM/YY',
  `format_exp` varchar(50) NOT NULL COMMENT 'Pola tanggal EXP',
  `shelf_life_bulan` int(11) NOT NULL DEFAULT 0,
  `catatan_koreksi` varchar(255) DEFAULT NULL COMMENT 'misal: dikurang 2 hari / ditambah 3 hari',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Master format kodefikasi PROD/EXP per SKU+Buyer, shared FG & WIP';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_kode_grup_packing`
--

CREATE TABLE `master_kode_grup_packing` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_pengawas` varchar(150) NOT NULL,
  `bagian` varchar(100) NOT NULL COMMENT 'misal: PACKING LINE 1, PACKING HCO 1, dst',
  `kode_grup` varchar(5) NOT NULL COMMENT '2 digit kode pengawas',
  `ka_shift` varchar(150) DEFAULT NULL,
  `shift` char(1) DEFAULT NULL COMMENT 'A/B/C, huruf depan Regu',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Master kode grup packing untuk hitung KodePengawas di kode TGR';

-- --------------------------------------------------------

--
-- Struktur dari tabel `master_regu_line`
--

CREATE TABLE `master_regu_line` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line` varchar(30) NOT NULL COMMENT 'misal: 1,2,3,4 atau "wip"',
  `shift` char(1) NOT NULL COMMENT 'A/B/C',
  `nama_regu` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Contoh isi utk line=wip: A-Teddy, B-Sofyan, C-Rizan';

-- --------------------------------------------------------

--
-- Struktur dari tabel `stb_fg`
--

CREATE TABLE `stb_fg` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Header Surat Terima Barang FG';

-- --------------------------------------------------------

--
-- Struktur dari tabel `stb_fg_items`
--

CREATE TABLE `stb_fg_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stb_fg_id` bigint(20) UNSIGNED NOT NULL,
  `no_urut` int(11) NOT NULL,
  `no_po` varchar(100) DEFAULT NULL,
  `sku` varchar(30) DEFAULT NULL,
  `nama_produk` varchar(255) DEFAULT NULL COMMENT 'Auto-fill dari SKU kalau diisi',
  `ukuran` varchar(100) DEFAULT NULL COMMENT 'misal 12x20x25g, manual/auto sesuai master',
  `buyer` varchar(150) DEFAULT NULL COMMENT 'Manual (baris Keterangan #1 di versi lama)',
  `plan_mc` decimal(12,2) DEFAULT NULL,
  `plan_jam` decimal(12,2) DEFAULT NULL,
  `plan_speed` decimal(12,2) DEFAULT NULL,
  `plan_hasil` decimal(14,2) DEFAULT NULL COMMENT 'Computed: plan_mc * plan_jam * plan_speed',
  `hasil_proses` enum('MC Suzuki','Topack','Reguler','Dispenser','MC KEED') DEFAULT NULL,
  `kodefikasi` varchar(150) DEFAULT NULL COMMENT 'Manual, isi kode fisik di karton',
  `satuan` varchar(30) DEFAULT NULL,
  `jumlah` decimal(14,2) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL COMMENT 'Keterangan tambahan bebas (di luar field2 di atas)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Baris item Surat Terima Barang FG, 1 baris = 1 SKU';

-- --------------------------------------------------------

--
-- Struktur dari tabel `stb_wip`
--

CREATE TABLE `stb_wip` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Header Surat Terima Barang WIP';

-- --------------------------------------------------------

--
-- Struktur dari tabel `stb_wip_items`
--

CREATE TABLE `stb_wip_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stb_wip_id` bigint(20) UNSIGNED NOT NULL,
  `no_urut` int(11) NOT NULL,
  `no_po` varchar(100) DEFAULT NULL,
  `sku` varchar(30) DEFAULT NULL COMMENT 'Opsional, dipakai utk lookup nama produk otomatis',
  `jenis_barang_jadi` varchar(255) DEFAULT NULL COMMENT 'Auto-fill dari SKU kalau diisi',
  `satuan` varchar(30) DEFAULT 'KARTON',
  `jumlah` decimal(14,2) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL COMMENT 'Free text manual',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Baris item Surat Terima Barang WIP';

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `checklist_wrapping`
--
ALTER TABLE `checklist_wrapping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cw_tanggal` (`tanggal`),
  ADD KEY `idx_cw_source` (`source_type`);

--
-- Indeks untuk tabel `hasil_produksi`
--
ALTER TABLE `hasil_produksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hp_tanggal` (`tanggal`),
  ADD KEY `idx_hp_sku` (`sku`);

--
-- Indeks untuk tabel `identitas_fg`
--
ALTER TABLE `identitas_fg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_ifg_kode_barang` (`kode_barang`),
  ADD KEY `idx_ifg_tanggal` (`tanggal_produksi`);

--
-- Indeks untuk tabel `identitas_wip`
--
ALTER TABLE `identitas_wip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_iwip_kode_barang` (`kode_barang`),
  ADD KEY `idx_iwip_tanggal` (`tanggal_produksi`);

--
-- Indeks untuk tabel `master_barang_fg`
--
ALTER TABLE `master_barang_fg`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mbfg_kode` (`kode`),
  ADD KEY `idx_mbfg_buyer` (`buyer`);

--
-- Indeks untuk tabel `master_barang_wip`
--
ALTER TABLE `master_barang_wip`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mbwip_kode` (`kode`),
  ADD KEY `idx_mbwip_buyer` (`buyer`);

--
-- Indeks untuk tabel `master_buyer`
--
ALTER TABLE `master_buyer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_nama_buyer` (`nama_buyer`);

--
-- Indeks untuk tabel `master_kodefikasi_buyer`
--
ALTER TABLE `master_kodefikasi_buyer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sku_buyer` (`sku`,`buyer`),
  ADD KEY `idx_mkb_sku` (`sku`);

--
-- Indeks untuk tabel `master_kode_grup_packing`
--
ALTER TABLE `master_kode_grup_packing`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_mkgp_bagian_shift` (`bagian`,`shift`);

--
-- Indeks untuk tabel `master_regu_line`
--
ALTER TABLE `master_regu_line`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_line_shift` (`line`,`shift`);

--
-- Indeks untuk tabel `stb_fg`
--
ALTER TABLE `stb_fg`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `stb_fg_items`
--
ALTER TABLE `stb_fg_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_stbfg_items_header` (`stb_fg_id`),
  ADD KEY `idx_stbfgitems_sku` (`sku`);

--
-- Indeks untuk tabel `stb_wip`
--
ALTER TABLE `stb_wip`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `stb_wip_items`
--
ALTER TABLE `stb_wip_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_stbwip_items_header` (`stb_wip_id`),
  ADD KEY `idx_stbwipitems_sku` (`sku`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `checklist_wrapping`
--
ALTER TABLE `checklist_wrapping`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `hasil_produksi`
--
ALTER TABLE `hasil_produksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `identitas_fg`
--
ALTER TABLE `identitas_fg`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `identitas_wip`
--
ALTER TABLE `identitas_wip`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_barang_fg`
--
ALTER TABLE `master_barang_fg`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_barang_wip`
--
ALTER TABLE `master_barang_wip`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_buyer`
--
ALTER TABLE `master_buyer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_kodefikasi_buyer`
--
ALTER TABLE `master_kodefikasi_buyer`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_kode_grup_packing`
--
ALTER TABLE `master_kode_grup_packing`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `master_regu_line`
--
ALTER TABLE `master_regu_line`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `stb_fg`
--
ALTER TABLE `stb_fg`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `stb_fg_items`
--
ALTER TABLE `stb_fg_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `stb_wip`
--
ALTER TABLE `stb_wip`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `stb_wip_items`
--
ALTER TABLE `stb_wip_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `stb_fg_items`
--
ALTER TABLE `stb_fg_items`
  ADD CONSTRAINT `fk_stbfg_items_header` FOREIGN KEY (`stb_fg_id`) REFERENCES `stb_fg` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `stb_wip_items`
--
ALTER TABLE `stb_wip_items`
  ADD CONSTRAINT `fk_stbwip_items_header` FOREIGN KEY (`stb_wip_id`) REFERENCES `stb_wip` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
