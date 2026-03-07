# Gentleman Programming - Secciones Clave Extraídas

**Fuente**: Gentleman Programming Book (Español)  
**Fecha de Extracción**: 2026-03-07  
**PDF**: `/Users/statick/Documents/books/gentleman-programming-book-es.pdf`

---

## 1️⃣ DEFINITION OF DONE / CRITERIOS DE ACEPTACIÓN

### Contenido Clave

El libro enfatiza que antes de mover una tarea como "lista", el equipo debe tener claro:
- **¿Cuáles son los criterios de aceptación que necesitamos completar?**
- Recordar que una funcionalidad necesita tener inicio y final propio para proporcionar valor mientras es independiente

### Criterios de Aceptación - Ejemplo de User Story

El libro proporciona ejemplos de estructura:

```
US-001: Como usuario, quiero ver lista de tareas para organizarme
Criterios de Aceptación:
- Mostrar lista vacía con mensaje "No hay tareas" al inicio
- Cada tarea muestra: título, prioridad (badge color), estado
- Ordenar por fecha creación (más reciente primero)
- Notas técnicas: Usar datos mockeados inicialmente

US-002: Como usuario, quiero crear una nueva tarea
Criterios de Aceptación:
- Formulario: título (requerido, 3-100 chars), descripción (opcional), prioridad (select)
- Botón "Crear" deshabilitado si título inválido
- Tarea aparece inmediatamente en lista
- Limpiar formulario después de crear
- Validaciones: Título entre 3-100 caracteres
```

### Aplicabilidad SDD

- **sdd-spec**: Escribir criterios de aceptación explícitos en especificaciones
- **sdd-verify**: Validar que implementación cumple con todos los criterios
- **sdd-prd**: Definir acceptance criteria en la fase PRD
- **sdd-apply**: Usar criterios de aceptación como checklist durante implementación

### Página/Referencia

Cap. 1-2: Código Limpio y Agilidad / Comunicación en Primer Lugar

---

## 2️⃣ CODE REVIEW / REVISIÓN DE CÓDIGO

### Filosofía de Revisión

El libro establece que Code Reviews deben:
- **Fomentar mejoras en el tipado** (especialmente para TypeScript)
- **Priorizar la claridad** del código
- **Ser centradas en mejores prácticas** del framework (React, Angular, etc.)

### Estándares de Código

El libro recomienda:
1. **Establecer estándares desde el inicio**: React es muy flexible, pero esa flexibilidad puede llevar a inconsistencias
2. **Definir guías de estilo y arquitectura** claras
3. **No sacrificar calidad por velocidad**: Implementar pruebas unitarias e integración desde el principio

### Roles del Revisor (Implícito)

Aunque no está explícitamente desglosado, el enfoque es:
- **Mejorador**: Sugerencias para mejor tipado y claridad
- **Guardián de estándares**: Asegurar que se siguen convenciones establecidas
- **Educador**: Compartir conocimiento de mejores prácticas

### Aplicabilidad SDD

- **sdd-verify**: Phase donde ocurren las revisiones de código
- **differential-review** (skill): Revisión diferencial de PRs enfocada en seguridad
- **sdd-apply**: Implementación con consideración de futuros reviews

### Página/Referencia

Cap. 5-6: React Best Practices / TypeScript Mastery

---

## 3️⃣ PAIR PROGRAMMING

### Cuándo Hacer Pair Programming

El libro lo menciona como práctica para:
- **Distribuir conocimiento** entre oficinas remotas/distribuidas
- **Generar estructura** entre equipos globales
- **Minimizar la cantidad de colaboración** necesaria después

### Objetivos del Pair Programming

1. **Knowledge Sharing**: Compartir conocimiento técnico entre desarrolladores
2. **Distributed Teams**: Conectar equipos en diferentes zonas horarias
3. **Quality Assurance**: Detectar problemas temprano con dos pares de ojos

### Driver/Navigator Pattern

No está explícitamente detallado en las secciones extraídas, pero la filosofía de equipo sugiere:
- Un desarrollador coding (driver)
- Otro observando/orientando (navigator)

### Duración y Estructura

No especifica duración explícita, pero se alinea con:
- **Ritmo sostenible**: No quemar al equipo con sesiones largas
- **Pequeñas funcionalidades**: Pair programming en features atómicas

### Aplicabilidad SDD

- **sdd-apply**: Fase donde pair programming es más efectivo
- **sdd-design**: Sesiones de pair para decisiones arquitectónicas
- **Knowledge Transfer**: Parte crítica de la metodología

### Página/Referencia

Cap. 2: Comunicación en Primer Lugar / Distributed Teams

---

## 4️⃣ CLEAN CODE PATTERNS

### Filosofía Central: "¿Por qué?" no "¿qué?"

El libro enfatiza que el código debe comunicar la intención, no solo lo que hace.

### Naming Conventions

El libro establece que:
- El código debe ser **claro, simple y bien comunicado** a compañeros de equipo
- Debe ser fácil ver código y decir "¡wow, esto es genial!" o "¡wow, qué desorden!"
- Los nombres deben revelar la intención

### Atomic/Modular Design (Front End Perspective)

**Separa tu código en la cantidad mínima de lógica posible:**
- Cuanto más pequeño sea el código, más fácil será de probar
- Beneficios: Reutilización, mejor mantenimiento, mejor rendimiento
- Acoplamiento más suelto, cohesión más alta posible

### Function Size Guidelines

- **Pequeñas funciones**: Fáciles de probar y mantener
- **Responsabilidad única**: Cada función hace una cosa
- **Lógica separada**: Identificar requisitos claramente

### Error Handling Patterns

Cap. 15 menciona:
- **Clean Architecture** con separación clara de capas
- **Security Basics** en la capa externa
- Validación de entrada como parte fundamental

### Comments Philosophy

Aunque no está explícitamente detallado:
- El código debe ser self-documenting
- Los comentarios deberían explicar **por qué**, no **qué**
- La funcionalidad atómica hace el código más legible

### Aplicabilidad SDD

- **sdd-apply**: Seguir clean code patterns durante implementación
- **sdd-verify**: Revisar que el código siga patrones atomizados
- **sdd-design**: Arquitectura atómica desde el diseño

### Página/Referencia

Cap. 1: Código Limpio y Agilidad / Atomic Design  
Cap. 15: Clean Architecture en Front End

---

## 5️⃣ TESTING PHILOSOPHY - TDD

### TDD Approach: Red-Green-Refactor

**El proceso es:**

1. **Red**: Escribir pruebas que fallarán (porque el código no existe)
2. **Green**: Escribir el código mínimo para que pasen las pruebas
3. **Refactor**: Mejorar el código manteniendo las pruebas verdes

### Por qué TDD

El libro reconoce que "todo el mundo odia hacer pruebas", pero identifica compensaciones:

1. **Calidad del código**: Pruebas fuerzan mejor organización
2. **Mantenimiento del código**: Facilita futuros cambios sin miedo a romper
3. **Velocidad de programación**: Contraintuitivo, pero TDD acelera desarrollo a largo plazo

### Test Coverage Expectations

**Relación entre calidad y testing:**
- Código de calidad: "claro, simple, bien probado, libre de errores, refactorizado, documentado y con buen rendimiento"
- No se puede lograr 100%, pero se debe maximizar dentro del contexto
- Mejor entregar algo feo funcional que algo hermoso pero incompleto

### Unit vs Integration vs E2E

No está explícitamente desglosado, pero el enfoque es:
- **Atomic Testing**: Pruebas pequeñas para lógica pequeña
- **Acceptance Tests**: Pruebas que validen los criterios de aceptación
- **Integration**: Componentes trabajando juntos

### Mocking/Stubbing Patterns

Cap. 2 menciona datos "mockeados inicialmente":
```
US-001: Como usuario, quiero ver lista de tareas
Notas técnicas: Usar datos mockeados inicialmente
```

### TDD + User Stories

El libro une ambos conceptos:

```
Historia de Usuario:
- ¿Qué? (Quién, qué, por qué)
- ¿Cómo? (Casos de uso/steps)

Casos de uso → Se convierten en pruebas
Pruebas fallan → Se escribe código
Pruebas pasan → Refactor si necesario
```

### Metodología

**El proceso de TDD:**
1. ¿Qué quieres hacer?
2. ¿Cuáles son los requisitos principales?
3. Escribir pruebas que fallarán alrededor
4. Crear tu código sabiendo lo que quieres
5. Hacer que la prueba pase

### Aplicabilidad SDD

- **sdd-spec**: Especificaciones contienen casos de uso que se convierten en pruebas
- **sdd-apply**: Implementar siguiendo TDD (Red-Green-Refactor)
- **sdd-verify**: Verificar que todas las pruebas pasan

### Página/Referencia

Cap. 1: "Desarrollo Guiado por Pruebas (TDD)" y "Historias de Usuario y TDD"

---

## 6️⃣ SECURITY & QUALITY GATES

### Requisitos de Seguridad

El libro dedica el Cap. 15 a:
- **"Rendimiento y Seguridad en la Capa Externa"**
- **Security Basics**: Privacy, Permissions
- Asegurarse que sistemas son "robustos y seguros"

### Validación de Entrada

**Ejemplo en Clean Architecture:**

```typescript
// Lógica de Dominio - Validación en la entidad
class Cuenta {
  constructor(private edad: number) {
    if (!this.esMayorDeEdad()) {
      throw new Error("Debe ser mayor de 18 años para abrir una cuenta.");
    }
  }
  private esMayorDeEdad() {
    return this.edad >= 18;
  }
}

// Lógica de Aplicación - Orquestación
class CrearCuentaService {
  constructor(private cuentaRepo: CuentaRepository) {}
  crearCuenta(datosCliente: { edad: number }) {
    const cuenta = new Cuenta(datosCliente.edad);
    this.cuentaRepo.guardar(cuenta);
  }
}
```

### Three Layers of Logic

El libro define tres tipos de lógica que deben separarse:

1. **Lógica de Dominio**: Reglas de negocio núcleo (ej: validación de edad)
2. **Lógica de Aplicación**: Orquestación y coordinación (ej: guardar en repo)
3. **Lógica de Empresa**: Políticas organizacionales (ej: auditorías anuales requeridas)

### Dependency Management

Aunque no está explícitamente detallado en las secciones, la arquitectura hexagonal enfatiza:
- **Separación de preocupaciones**
- **Inversión de dependencias**: Las dependencias apuntan hacia adentro
- **Adaptadores**: Mediar comunicación entre componentes

### TypeScript Strict Mode

Cap. 5 recomienda:
- **Revisiones de código focalizadas en tipado**
- **Claridad a través de tipos**
- **Strict mode enabled** para máxima seguridad

### Aplicabilidad SDD

- **sdd-design**: Arquitectura debe considerar seguridad desde el inicio
- **sdd-verify**: Validar que validaciones de entrada están en lugar
- **sdd-apply**: Implementar con seguridad como requisito no funcional
- **differential-review** (skill): Revisar cambios por vulnerabilidades

### Página/Referencia

Cap. 15: Rendimiento y Seguridad / Lógica en Capas  
Cap. 4: Arquitectura Hexagonal

---

## 📊 MATRIZ DE APLICABILIDAD EN SDD

| Sección | sdd-propose | sdd-spec | sdd-design | sdd-apply | sdd-verify | sdd-archive |
|---------|------------|----------|-----------|-----------|-----------|------------|
| Definition of Done | Definir | ✅ Criterios claro | - | Checklist | ✅ Validar | Documento |
| Code Review | - | - | - | Con reviews | ✅ Revisar | Feedback |
| Pair Programming | - | - | ✅ Decisiones | ✅ Durante | - | Conocimiento |
| Clean Code | Mención | Código refs | ✅ Arquitectura | ✅ Principal | ✅ Revisar | Estándares |
| TDD | - | Casos de uso | Test design | ✅ Red-Green | ✅ Tests pasan | Coverage report |
| Security Gates | Reqs | Validación reqs | ✅ Layers | ✅ Implementar | ✅ Security check | Audit trail |

---

## 🎯 RECOMENDACIONES DE INTEGRACIÓN

### Workflow Propuesto

1. **sdd-propose**: Incluir filosofía de TDD y clean code
2. **sdd-spec**: Escribir criterios de aceptación claros + casos de uso para pruebas
3. **sdd-design**: Considerar security layers + pair programming para decisions
4. **sdd-apply**: Implementar con TDD, atomic functions, TypeScript strict
5. **sdd-verify**: Code review con enfoque en tipado, criterios aceptación, tests verdes
6. **sdd-archive**: Documentar estándares establecidos para futuros proyectos

### Skills a Usar Conjuntamente

- **tdd** (skill): Test-Driven Development workflow
- **clean-code** (skill): Clean code patterns and conventions
- **typescript** (skill): TypeScript strict patterns
- **security** (skill): Security best practices in code
- **github-pr** (skill): High-quality PRs with code review patterns

---

## 📖 REFERENCIAS COMPLETAS

**Capítulos Mencionados:**
- Cap. 1: Código Limpio y Agilidad
- Cap. 2: Comunicación en Primer Lugar  
- Cap. 3: Arquitectura Hexagonal
- Cap. 4: GoLang
- Cap. 5: React Best Practices / TypeScript
- Cap. 6: NVIM
- Cap. 7: Algoritmos
- Cap. 15: Rendimiento y Seguridad en la Capa Externa
- Cap. 18: Scripts y Automatización

**Temas Clave:**
- Extreme Programming (XP) con 3 anillos
- Historias de Usuario + Criterios de Aceptación
- Agile vs Pseudo-Agile
- Design Atómico
- Pair Programming para distributed teams
- Clean Architecture (Front End y Back End)

---

**Última actualización**: 2026-03-07  
**Extraído por**: OpenCode AI  
**Estado**: Listo para integración en SDD workflow
