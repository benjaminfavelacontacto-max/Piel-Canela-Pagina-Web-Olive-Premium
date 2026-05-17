# Piel Canela · Spa & Bronceado — Contexto del proyecto

## Qué es este proyecto
Sitio web oficial de **Piel Canela · Spa & Bronceado**, Guadalajara. Es un sitio de una sola página principal (`index.html`) más una página de cursos (`cursos.html`). Todo el HTML, CSS y JS de cada página vive en un solo archivo — no hay archivos separados de CSS ni JS.

## Archivos principales
- `index.html` — Página principal. Toda la estética, lógica y contenido aquí.
- `cursos.html` — Página independiente de cursos. Mismos tokens CSS, nav y footer que index.
- `uploads/` — Carpeta de imágenes y videos del sitio.

## Sistema de diseño (tokens CSS)
```css
--bg-0: #0a0705;   /* fondo más oscuro */
--bg-1: #110e0a;
--bg-2: #1a1510;
--gold-warm: #c9a96e;
--cream: #f5efe6;
--border-soft: rgba(201,169,110,.15);
--ff-display: 'Playfair Display', serif;
--ff-body: 'Inter', sans-serif;
--maxw: 1280px;
--pad-x: clamp(1.25rem, 5vw, 4rem);
```

## Estructura de secciones en index.html (en orden)
1. NAV fijo
2. HERO (video de fondo)
3. NOSOTROS
4. TESTIMONIOS (reseñas Google) ← va ANTES de servicios
5. SERVICIOS — Progressive disclosure: 3 tarjetas cinéticas (Técnica UV, Cabina, Spray) → expanden paneles con paquetes
6. GALERÍA — Dos filas de marquee con drag/swipe momentum
7. RESULTADOS
8. UBICACIÓN
9. FOOTER

## Paquetes actuales de Cabina (en index.html #panel-cabina)
- **Básico**: 1 sesión $780 / 3 sesiones $2,180 — incluye lo mismo que Gold pero SIN exfoliación y SIN baño de luna
- **Gold**: 1 sesión $1,280 / 3 sesiones $2,645 — incluye: activador, potencializador, protección ocular y facial, mascarilla colágeno, baño de luna, exfoliación

## Galería (JS)
- Drag/swipe con momentum (dragOffset + dragVelocity)
- Fila 2 tiene dirección invertida (`dragSign = row2.contains(target) ? -1 : 1`)
- `passive: false` en touchmove + `e.preventDefault()` solo cuando gesto es horizontal
- `render()` directo en scroll (sin RAF) para eliminar lag

## Git workflow — IMPORTANTE
El sandbox NO puede hacer git push. Benjamin lo hace manualmente desde la terminal de VS Code.
- Atajo para abrir terminal en VS Code: **Ctrl + `** (tecla acento grave, arriba del Tab)
- Comandos para subir cambios:
  ```
  git add .
  git commit -m "descripción del cambio"
  git push
  ```
- Si hay error de HEAD.lock: `rm -f .git/HEAD.lock` y vuelve a intentar

## cursos.html — estado actual
- Hero con título "Aprende la técnica del bronceado brasileño"
- Sección intro: grid 2 columnas (texto izq + visual der)
- Visual container: `aspect-ratio: 4/5` en desktop (~560×700px), `16/9` en móvil
- Actualmente usa imagen `uploads/lugar.jpg` — pendiente reemplazar con video (usuario lo subirá)
- Sección "Para quién": 3 tarjetas
- CTA con WhatsApp

## Cómo trabajamos
- Claude edita directamente `index.html` y `cursos.html` usando la herramienta Edit/Write
- Benjamin ve los cambios en la barra de archivos de VS Code en tiempo real
- Para git push, Benjamin abre terminal (Ctrl+`) y ejecuta los comandos de arriba
- Claude da los comandos exactos cuando sea necesario

## Tarea pendiente al inicio de nueva conversación
Reemplazar imagen estática en `cursos.html` (sección intro-visual) con un video que Benjamin subirá. El contenedor es portrait 4:5 en desktop, ideal 720×900px o 1080×1350px, usa `object-fit: cover`.
