# FiveM Police Job Chat (v7-jobc)

A simple and efficient police job chat system for FiveM servers using QBCore framework.

Basit ve verimli bir FiveM polis meslek chat sistemi. QBCore framework'ü kullanır.

## 🚀 Features / Özellikler

### English
- **Police-only communication**: Only police officers can use and see messages
- **Rank system**: Shows officer rank and name in messages
- **Database integration**: Works with QBCore player database
- **Performance optimized**: Minimal database queries
- **Easy installation**: Plug and play setup

### Türkçe
- **Sadece polis iletişimi**: Sadece polis memurları komutu kullanabilir ve mesajları görebilir
- **Rütbe sistemi**: Mesajlarda memurun rütbesi ve adı görünür
- **Veritabanı entegrasyonu**: QBCore oyuncu veritabanı ile çalışır
- **Performans optimize**: Minimal veritabanı sorgusu
- **Kolay kurulum**: Tak-çalıştır kurulum

## 📋 Requirements / Gereksinimler

- **FiveM Server**
- **QBCore Framework**
- **oxmysql** resource
- **MySQL Database**

## 📂 Installation / Kurulum

### English
1. Download all files and place them in `resources/v7-jobc/` folder
2. Add `ensure v7-jobc` to your `server.cfg`
3. Make sure `oxmysql` is running
4. Restart your server

### Türkçe
1. Tüm dosyaları indirin ve `resources/v7-jobc/` klasörüne yerleştirin
2. `server.cfg` dosyanıza `ensure v7-jobc` ekleyin
3. `oxmysql` kaynağının çalıştığından emin olun
4. Sunucunuzu yeniden başlatın

## 📁 File Structure / Dosya Yapısı

```
v7-jobc/
├── fxmanifest.lua    # Resource manifest
├── server.lua        # Main server script
└── README.md         # This file
```

## 🎮 Usage / Kullanım

### English
**Command**: `/jobc [message]`

**Example**: `/jobc All units, we have a 10-54 at Legion Square`

**Output**: `Komiser John Doe: All units, we have a 10-54 at Legion Square`

### Türkçe
**Komut**: `/jobc [mesaj]`

**Örnek**: `/jobc Tüm birimler, Legion Meydanı'nda olay var`

**Çıktı**: `Komiser John Doe: Tüm birimler, Legion Meydanı'nda olay var`

## 🏆 Rank System / Rütbe Sistemi

| Level | English | Türkçe |
|-------|---------|--------|
| 0 | Officer | Memur |
| 1 | Senior Officer | Başmemur |
| 2 | Detective | Komiser Yardımcısı |
| 3 | Sergeant | Komiser |
| 4 | Lieutenant | Başkomiser |
| 5 | Captain | Emniyet Müdürü |

## ⚙️ Configuration / Yapılandırma

### English
The script automatically reads player data from the QBCore `players` table:

- **Job Check**: `job.name` must be `'police'`
- **Character Info**: Gets `firstname` and `lastname` from `charinfo` JSON
- **Rank**: Uses `job.grade.level` for rank determination

### Türkçe
Script otomatik olarak QBCore `players` tablosundan oyuncu verilerini okur:

- **Meslek Kontrolü**: `job.name` değeri `'police'` olmalı
- **Karakter Bilgisi**: `charinfo` JSON'ından `firstname` ve `lastname` alır
- **Rütbe**: Rütbe belirleme için `job.grade.level` kullanır

## 🗄️ Database Schema / Veritabanı Şeması

### English
The script expects the following database structure:

### Türkçe
Script aşağıdaki veritabanı yapısını bekler:

```sql
players table:
├── license (VARCHAR)     # Player license identifier
├── charinfo (JSON)       # Character information
└── job (JSON)           # Job information
```

**charinfo JSON example**:
```json
{
  "firstname": "John",
  "lastname": "Doe",
  "phone": "1234567890",
  "cid": 1
}
```

**job JSON example**:
```json
{
  "name": "police",
  "label": "LSPD",
  "grade": {
    "level": 3,
    "name": "Sergeant"
  }
}
```

## 🔧 Troubleshooting / Sorun Giderme

### English

**"Player information could not be retrieved" error**:
- Check if oxmysql is running
- Verify database connection
- Make sure player is in the database

**"Only police officers can use this command" error**:
- Check if player's job name is "police"
- Verify job information in database
- Make sure player is logged in properly

**Messages not showing**:
- Check if target players have police job
- Verify chat system is working
- Check server console for errors

### Türkçe

**"Oyuncu bilgileri alınamadı" hatası**:
- oxmysql'in çalıştığını kontrol edin
- Veritabanı bağlantısını doğrulayın
- Oyuncunun veritabanında olduğundan emin olun

**"Bu komutu sadece polis memurları kullanabilir" hatası**:
- Oyuncunun job name'inin "police" olduğunu kontrol edin
- Veritabanındaki job bilgilerini doğrulayın
- Oyuncunun düzgün giriş yaptığından emin olun

**Mesajlar görünmüyor**:
- Hedef oyuncuların polis mesleği olduğunu kontrol edin
- Chat sisteminin çalıştığını doğrulayın
- Sunucu konsolunda hata olup olmadığını kontrol edin

## 🛠️ Customization / Özelleştirme

### English
To modify ranks, edit the `ranks` table in `server.lua`:

### Türkçe
Rütbeleri değiştirmek için `server.lua` dosyasındaki `ranks` tablosunu düzenleyin:

```lua
local ranks = {
    [0] = "Your Custom Rank",
    [1] = "Another Rank",
    -- Add more ranks as needed
}
```

### Change Chat Prefix / Chat Önekini Değiştirme
```lua
args = {"[YOUR PREFIX]", formattedMessage}
```

### Change Command Name / Komut Adını Değiştirme
```lua
RegisterCommand('yourcmd', function(source, args, rawCommand)
```

## 📝 License / Lisans

This project is open source and available under the [MIT License](LICENSE).

Bu proje açık kaynak kodludur ve [MIT Lisansı](LICENSE) altında mevcuttur.

## 🤝 Contributing / Katkıda Bulunma
me and belowed me

### English
Contributions are welcome! Please feel free to submit pull requests or open issues.

### Türkçe
Katkılarınız memnuniyetle karşılanır! Lütfen pull request göndermekten veya issue açmaktan çekinmeyin.


### English
- Create an issue on GitHub
- Contact the developer
- Check FiveM community forums

### Türkçe
- GitHub'da issue oluşturun
- Geliştirici ile iletişime geçin
- FiveM topluluk forumlarını kontrol edin

---

**Version / Sürüm**: 1.0.0  
**Last Updated / Son Güncelleme**: 2025-07-20  
**Author / Yazar**: [Your Name]
