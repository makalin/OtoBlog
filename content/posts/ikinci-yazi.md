---
title: "Hugo ile Statik Site Oluşturma"
date: 2024-01-02T14:30:00+03:00
draft: false
description: "Hugo kullanarak hızlı ve güvenli statik siteler nasıl oluşturulur?"
tags: ["hugo", "static-site", "web-development"]
categories: ["teknoloji"]
---

# Hugo ile Statik Site Oluşturma

Hugo, Go programlama dili ile yazılmış hızlı ve modern bir statik site oluşturucusudur. Bu yazıda Hugo'nun temel özelliklerini ve nasıl kullanılacağını öğreneceğiz.

## Hugo'nun Avantajları

### 1. Hız
Hugo, Go dilinin hızından yararlanarak siteleri çok hızlı bir şekilde oluşturur. Binlerce sayfa bile saniyeler içinde build edilebilir.

### 2. Güvenlik
Statik siteler sunucu tarafında kod çalıştırmadığı için güvenlik açıklarına karşı daha dayanıklıdır.

### 3. SEO Dostu
Hugo, SEO optimizasyonu için gerekli tüm özellikleri sağlar.

## Temel Kullanım

### Yeni Site Oluşturma

```bash
hugo new site myblog
cd myblog
```

### Tema Ekleme

```bash
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo 'theme = "ananke"' >> config.toml
```

### Yeni İçerik Ekleme

```bash
hugo new posts/ilk-yazim.md
```

### Siteyi Build Etme

```bash
hugo --minify
```

## Markdown Özellikleri

Hugo, standart Markdown'ın yanı sıra kendi özel kısayollarını da destekler:

### Front Matter

```yaml
---
title: "Yazı Başlığı"
date: 2024-01-02T14:30:00+03:00
draft: false
tags: ["hugo", "blog"]
categories: ["teknoloji"]
---
```

### Kısayollar

```markdown
{{< figure src="/images/resim.jpg" title="Resim Açıklaması" >}}
```

## Özelleştirme

Hugo, tema özelleştirmesi için güçlü araçlar sunar:

- **Layouts**: HTML şablonları
- **Assets**: CSS, JS dosyaları
- **Static**: Resimler, favicon vb.
- **Content**: Markdown dosyaları

## Deployment

Hugo siteleri çeşitli platformlara kolayca deploy edilebilir:

- GitHub Pages
- Netlify
- Vercel
- AWS S3
- Docker + Kubernetes (bizim projemizde)

## Sonuç

Hugo, modern web geliştirme için mükemmel bir araçtır. Hızı, güvenliği ve esnekliği ile öne çıkar. Bu blog da Hugo kullanılarak oluşturulmuştur.

---

*Bu yazı Hugo'nun temel özelliklerini kapsamaktadır. Daha detaylı bilgi için [Hugo resmi dokümantasyonunu](https://gohugo.io/documentation/) inceleyebilirsiniz.* 