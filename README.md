# Remed Prak PAB
1462300094 Muhammad Edhu Maulana

# TOPIK & TEMA PROJECT 
Tema Utama: SpaceNews Core - Advanced International News Portal 
Target REST API: https://api.spaceflightnewsapi.net/v4/articles/?limit=20  
Arsitektur Data & Backend: Firebase Authentication, Firebase Firestore, dan 
SharedPreferences (Local Storage) 

# DETAIL SPESIFIKASI DAN ALUR HALAMAN 
1. Splash Screen & Session Handling 
  • Durasi 
    Wajib berjalan dengan delay tepat 3 detik. 
  • Komponen 
    Menampilkan logo aplikasi dan CircularProgressIndicator di tengah 
    layar. 
2. Halaman Daftar 
  Berisi: 
    • Logo 
    • Nama 
    • Email 
    • Password 
    • Button "Daftar" 
    • Button "Apakah sudah punya akun? Login" 
3. Halaman Forgot Password 
  Berisi: 
    • Email 
    • Button "Send to email" 
4. Halaman Login 
  Berisi: 
    • Logo 
    • Email 
    • Password 
    • Button "Forgot Password?" 
    • Button "Login" 
5. Welcome Page  
  Komponen: Menampilkan teks sambutan "Welcome to SpaceNews Core 
  Application", gambar ilustrasi jurnalisme dari internet 
6. Home Page (Dashboard & Feed Berita) 
  • Komponen 
    Menggunakan Scaffold dengan BottomNavigationBar yang memiliki 4 
    menu aktif yaitu Home (Dashboard), Favorite, Notification, dan Profile. 
  • Struktur Konten 
    Bagian atas menampilkan banner Headline News. Bagian bawah 
    menampilkan kumpulan berita secara dinamis. 
  • Aksi Klik 
    Jika salah satu kartu berita ditekan, arahkan ke Detail Page dengan 
    membawa objek data artikel. 
7. Detail Page (Ruang Baca Artikel) 
  • Komponen 
    Layout vertikal yang dapat digulir. Menampilkan foto berita ukuran 
    besar, judul lengkap, media penerbit, dan teks ringkasan ("summary"). 
  • Fitur Interaksi 
    Menyediakan Icon berbentuk hati di bagian atas/AppBar. 
  • Aksi Tombol Favorite 
    Mengubah ikon menjadi hati merah dan menyimpan data ID serta judul 
    artikel tersebut ke Firebase Firestore di dalam collection "favorites". 
  • Navigasi Kembali 
    Menyediakan tombol Back. 
8. Halaman Favorite 
  Menampilkan seluruh daftar artikel berita yang telah disimpan dari koleksi "favorites" 
  di Firebase Firestore secara real-time. 
9. Halaman Notifikasi 
  Menampilkan daftar feed pemberitahuan secara urut. 
10. Halaman Profile 
  • Komponen 
    Menampilkan foto profil, Nama Lengkap, Email, dan Akun Instagram secara 
    dinamis berdasarkan data pengguna yang aktif di Firebase Firestore. 
  • Tombol “Log Out” 
    Menghapus status session login, melakukan sign-out dari Firebase, dan 
    membersihkan seluruh tumpukan halaman  untuk kembali ke Halaman Daftar

# Hasil bisa dicek pada Folder dokumentasi
