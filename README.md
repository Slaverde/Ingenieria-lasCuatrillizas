# Ingenieria-lasCuatrillizas

# Papa Caliente

Juego de terror 3D con cámara fija (vista lateral y vista trasera). Motor: **Godot 4.7** (GDScript).

## Cómo correrlo
1. Instalar Godot 4.7.
2. Importar la carpeta (archivo `project.godot`) y dar Play (F5).
3. Controles: `A/D` mover · `W/S` avanzar/retroceder (vista trasera) · `E` interactuar/avanzar diálogo · `Shift` correr y `Espacio` saltar (solo en la persecución).

## Estructura
```
assets/     modelos, audio y UI (ver assets/README.md para convenciones de Blender)
scenes/     main, player, camera, ui y levels/ (10 niveles)
scripts/    autoload/ core/ player/ camera/ interaction/ levels/ dialogue/ minigames/ enemies/ ui/
data/       dialogues/*.json
docs/       ESCENARIOS.md (guion -> niveles, estado y pendientes)
AI_TRACE.md registro de uso de IA (solo agregar entradas)
```

