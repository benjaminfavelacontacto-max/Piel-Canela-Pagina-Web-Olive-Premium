# 🌿 Piel Canela WEB

Sitio web oficial de **Piel Canela · Spa & Bronceado**, Guadalajara, México.  
Especialistas en bronceado natural, cabina UV y aerografía.

---

## 📁 Estructura del proyecto

```
/
├── index.html          ← Todo el sitio (HTML + CSS + JS en un solo archivo)
├── tweaks-panel.jsx    ← Componente de soporte (no modificar)
├── README.md           ← Este archivo
└── uploads/            ← Todas las imágenes y videos
    ├── logo_pielcanela2_white.png
    ├── header 2.png
    ├── main-bg.mp4
    ├── 2.png
    ├── cabina 2.png
    ├── Aerografia 2.png
    ├── cintas 2.png
    ├── lugar.jpg
    ├── 2 morena.jpg
    ├── blanca.jpg
    ├── Google Maps Piel Canela.png
    └── ... (más assets)
```

---

## 🗂 Secciones del sitio

El archivo `index.html` está organizado con comentarios que marcan cada sección:

| Comentario | Descripción |
|---|---|
| `<!-- ───── NAV ───── -->` | Barra de navegación fija con logo y CTA |
| `<!-- ───── HERO ───── -->` | Sección principal con video de fondo |
| `<!-- ───── TICKER ───── -->` | Marquee animado de valores de marca |
| `<!-- ───── SERVICIOS ───── -->` | Cards de los 3 servicios principales |
| `<!-- ───── ABOUT ───── -->` | Sección "Nosotros" con imagen y valores |
| `<!-- ───── REELS ───── -->` | Galería de 3 imágenes principales |
| `<!-- ───── GALERÍA ───── -->` | Grid masonry de resultados |
| `<!-- ───── BOOKING ───── -->` | Formulario de reserva con envío a WhatsApp |
| `<!-- ───── TESTIMONIOS ───── -->` | Widget de reseñas de Google (Trustindex) |
| `<!-- ───── FAQ ───── -->` | Preguntas frecuentes con acordeón |
| `<!-- ───── CONTACT ───── -->` | Datos de contacto + mapa |
| `<!-- ───── FOOTER ───── -->` | Pie de página |
| `<!-- ───── FLOATING WA ───── -->` | Botón flotante de WhatsApp |

---

## ✏️ Modificaciones frecuentes

### Cambiar precios
Busca `card-price-num` en `index.html`:
```html
<div class="card-price-num">$1280</div>  <!-- Sol UV Natural -->
<div class="card-price-num">$780</div>   <!-- Cabina UV -->
<div class="card-price-num">$995</div>   <!-- Aerografía -->
```

### Cambiar número de WhatsApp
Busca y reemplaza `523332508073` en todo el archivo:
```html
href="https://wa.me/523332508073"
```

### Cambiar imágenes
Sube la imagen nueva a la carpeta `uploads/` y actualiza la ruta:
```html
<img src="uploads/tu-nueva-imagen.jpg" alt="Descripción">
```

### Cambiar colores del sitio
Al inicio del CSS, busca el bloque `TOKENS`:
```css
/* TOKENS · EDITORIAL TROPICAL WELLNESS */
:root {
  --bg-0: #1E2620;       /* Fondo principal */
  --gold-warm: #C2A878;  /* Accent champagne */
  --cream:     #F4F1EA;  /* Texto principal */
  ...
}
```

### Cambiar preguntas del FAQ
Busca `<!-- ───── FAQ ───── -->` y edita los bloques `.faq-item`:
```html
<div class="faq-item reveal">
  <div class="faq-q">Tu pregunta aquí<span class="faq-plus"></span></div>
  <div class="faq-a"><div class="faq-a-inner">Tu respuesta aquí</div></div>
</div>
```

### Cambiar horarios o dirección
Busca `<!-- ───── CONTACT ───── -->`:
```html
<div class="contact-val">Av. Guadalupe 6304, Zapopan, GDL</div>
<div class="contact-val">Lun – Dom · 09:00–17:00 hrs</div>
```

### Cambiar textos del hero
Busca `<!-- ───── HERO ───── -->`:
```html
<h1 class="reveal" data-delay="1">
  Tu bronceado<br><em>perfecto</em><br>todo el año.
</h1>
<p class="hero-sub reveal" data-delay="3">
  Especialistas en bronceado natural...
</p>
```

---

## 🎨 Sistema de diseño

### Paleta de colores
| Token | Valor | Uso |
|---|---|---|
| `--bg-0` | `#1E2620` | Fondo principal |
| `--bg-1` | `#232B25` | Fondo secundario |
| `--gold-warm` | `#C2A878` | Accent champagne (hovers, detalles) |
| `--gold-deep` | `#56634F` | Olive profundo (botones) |
| `--cream` | `#F4F1EA` | Texto principal |
| `--ink-soft` | `#DDD5C7` | Texto secundario |
| `--ink-mute` | `#9AA496` | Texto terciario |

### Tipografía
- **Display / Títulos:** `Cormorant Garamond` (serif elegante)
- **Cuerpo / UI:** `Inter` (sans-serif moderna)
- **Serif especial:** `Instrument Serif` (itálicas en títulos)

### Fuentes Google
```html
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500&family=Inter:wght@300;400;500;600&family=Instrument+Serif:ital,wght@0,400;1,400&display=swap" rel="stylesheet">
```

---

## 📱 Responsive

El sitio es mobile-first con 3 breakpoints:

| Breakpoint | Ancho |
|---|---|
| Mobile | `< 768px` |
| Tablet | `768px – 1024px` |
| Desktop | `> 1024px` |

---

## � Auto-sync local → GitHub

Hay un watcher listo para usar en `auto-sync.sh`. Desde la raíz del proyecto ejecuta:

```bash
./auto-sync.sh
```

El script hace lo siguiente:
- observa cambios en todo el proyecto
- espera 10 segundos después del último cambio
- hace `git add -A`
- hace un commit automático con un mensaje descriptivo
- hace `git push` a la rama remota configurada

Requisitos:
- `fswatch` instalado (`brew install fswatch`)
- la rama actual debe tener upstream configurado en GitHub

---
## 📤 Subir multimedia desde la terminal

Para copiar un nuevo archivo multimedia o video a la carpeta `uploads/`, commitearlo y empujarlo a GitHub, usa:

```bash
./upload-media.sh /ruta/al/archivo.mp4 "Agregar nuevo video"
```

El script:
- copia el archivo dentro de `uploads/`
- hace `git add` del archivo nuevo
- hace `git commit` con un mensaje automático o personalizado
- hace `git push origin <rama>` al upstream configurado

Si el nombre del archivo ya existe en `uploads/` y el contenido es distinto, te pedirá confirmación antes de sobrescribirlo.

---
## �🚀 Deploy en GitHub Pages

1. Subir todo el repositorio a GitHub (incluida la carpeta `uploads/`)
2. Ir a **Settings → Pages**
3. Source: `Deploy from a branch` → `main` → `/ (root)`
4. El sitio estará disponible en `https://tu-usuario.github.io/tu-repo/`

> ⚠️ Asegúrate de subir la carpeta `uploads/` completa — sin ella no se ven las imágenes.

---

## 📞 Contacto del negocio

| | |
|---|---|
| **WhatsApp** | +52 333 250 8073 |
| **Instagram** | [@pielcanela_spabronceado](https://www.instagram.com/pielcanela_spabronceado/) |
| **Dirección** | Av. Guadalupe 6304, Zapopan, Guadalajara |
| **Horario** | Lun – Dom · 09:00–17:00 hrs |

---

## 🛠 Tecnologías

- HTML5 semántico
- CSS3 (custom properties, grid, flexbox, animaciones)
- JavaScript vanilla (sin frameworks)
- Google Fonts
- Trustindex (widget de reseñas Google)

---

*Diseño editorial luxury wellness — paleta botanical olive + champagne brass*
