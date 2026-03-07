# Gentleman Programming - Checklists Operativos

**Basado en**: Gentleman Programming Book (ES)  
**Propósito**: Aplicación práctica en workflow SDD  
**Fecha**: 2026-03-07

---

## ✅ DEFINITION OF DONE CHECKLIST

### Antes de Marcar Tarea como "Lista"

- [ ] **Criterios de aceptación** están 100% completos
- [ ] **Funcionalidad tiene inicio y fin claro** (proporciona valor independiente)
- [ ] **Pruebas unitarias pasan** (TDD: red-green-refactor completado)
- [ ] **Code review aprobado** con foco en:
  - [ ] Tipado correcto (TypeScript strict)
  - [ ] Claridad del código
  - [ ] Mejores prácticas del framework
- [ ] **Validación de entrada implementada** (security layer)
- [ ] **Documentación actualizada** (comentarios en el "por qué")
- [ ] **Sin deuda técnica knowingly introducida**
- [ ] **Performance aceptable** (sin regresiones)
- [ ] **Listo para merge** a rama principal

---

## 🔍 CODE REVIEW CHECKLIST

### Para el Revisor

#### Tipado & Claridad
- [ ] Tipos explícitos (no `any`)
- [ ] Interfaces/Types bien definidos
- [ ] Nombres revelan intención
- [ ] No hay comentarios innecesarios ("qué" - evitar)

#### Mejores Prácticas del Framework
- [ ] Sigue convenciones del proyecto (React, Angular, etc.)
- [ ] Estándares de código están presentes
- [ ] Arquitectura es consistente

#### Security & Validation
- [ ] Inputs validados
- [ ] No hay hardcoded secrets
- [ ] Errors manejados apropiadamente
- [ ] Dependencias son seguras

#### Testing
- [ ] Tests son significativos (no solo cobertura)
- [ ] Edge cases cubiertos
- [ ] Mocks/Stubs apropiados

#### Atómicidad
- [ ] Funciones pequeñas y focalizadas
- [ ] Una responsabilidad por función
- [ ] Acoplamiento bajo, cohesión alta

#### Comunicación
- [ ] Sugerencias son constructivas (no agresivas)
- [ ] Se explica el "por qué" de cambios pedidos
- [ ] Se reconocen buenas decisiones

---

## 👥 PAIR PROGRAMMING CHECKLIST

### Antes de Sesión

- [ ] **Objetivo claro**: ¿Qué funcionalidad implementamos?
- [ ] **Duración planificada**: ¿Cuánto tiempo dedicamos?
- [ ] **Ritmo sostenible**: No quemar al equipo
- [ ] **Funcionalidad atómica**: Pequeña y contenida

### Durante la Sesión

- [ ] **Driver rotando**: (opcional pero recomendado cada 15-30 min)
- [ ] **Driver**: Código, pregunta al Navigator
- [ ] **Navigator**: Observa, sugiere, previene problemas
- [ ] **Comunicación fluida**: Sin silencios prolongados
- [ ] **Ambos entienden el código**: No solo el que escribe

### Después de Sesión

- [ ] **Conocimiento compartido**: Ambos comprenden la solución
- [ ] **Documentación actualizada**: Si es necesario
- [ ] **Tests pasan**: Resultado listo para review
- [ ] **Momentum mantenido**: Equipo no está quemado

---

## 🧹 CLEAN CODE CHECKLIST

### Naming Conventions

- [ ] Variables revelan intención
- [ ] Funciones nombran qué hacen
- [ ] Constantes en UPPER_SNAKE_CASE
- [ ] Métodos son verbos (getUser, createAccount)
- [ ] No números mágicos (usar constantes)

### Function/Method Size

- [ ] Una responsabilidad por función
- [ ] Máx 20-30 líneas (consider refactor si > 50)
- [ ] Parámetros ≤ 3 (considerar object si > 3)
- [ ] Early returns cuando sea posible
- [ ] No nested ternaries (máx 1 nivel)

### Comments Philosophy

- [ ] Comenta EL POR QUÉ, no el QUÉ
- [ ] Código habla por sí solo (names, structure)
- [ ] Comentarios explican decisiones no obvias
- [ ] TODO comments con razón clara
- [ ] Sin commented-out code (usar git history)

### Atomic/Modular Structure

- [ ] Componentes pequeños y reutilizables
- [ ] Cada componente hace UNA cosa
- [ ] Bajo acoplamiento (mínimas dependencias)
- [ ] Alta cohesión (relacionados lógicamente)
- [ ] Fácil de testear cada pieza

### Error Handling

- [ ] Errores handled explícitamente (no silent fails)
- [ ] Mensajes de error son claros
- [ ] Validación en el boundary (adapters)
- [ ] No magic error codes
- [ ] Recovery paths considerados

---

## 🧪 TESTING/TDD CHECKLIST

### Test Structure (Red-Green-Refactor)

**RED:**
- [ ] Test escrito ANTES que código
- [ ] Test falla por razones correctas
- [ ] Test es simple y específico

**GREEN:**
- [ ] Código mínimo para pasar test
- [ ] No features extra
- [ ] Test pasa
- [ ] Otros tests siguen pasando

**REFACTOR:**
- [ ] Mejorar código sin romper tests
- [ ] Tests siguen siendo verdes
- [ ] Código es más limpio/eficiente

### Test Coverage Expectations

- [ ] Happy path: ✅ (casos de uso principales)
- [ ] Error cases: ✅ (validaciones, excepciones)
- [ ] Edge cases: ✅ (límites, valores especiales)
- [ ] Coverage > 80% para lógica crítica
- [ ] 100% para utils y helpers críticos

### Unit Tests

- [ ] Una cosa por test
- [ ] Nombre describe el behavior
- [ ] Arrange-Act-Assert (AAA pattern)
- [ ] Mocks/Stubs cuando sea apropiado
- [ ] Setup/Teardown manejados

### Integration Tests

- [ ] Múltiples componentes juntos
- [ ] Datos reales (no solo mocks)
- [ ] End-to-end workflow
- [ ] Performance aceptable

### E2E Tests (si aplica)

- [ ] User scenarios completos
- [ ] Real browser/environment
- [ ] No flaky tests (determinísticos)
- [ ] Coverage de critical paths

---

## 🔒 SECURITY & QUALITY GATES CHECKLIST

### Input Validation

- [ ] Todos los inputs validados (frontend + backend)
- [ ] Validación en la capa de dominio (entities)
- [ ] Mensajes de error no revelan info sensitiva
- [ ] Limits/constraints (length, type, range)
- [ ] No inyecciones (SQL, XSS, etc.)

### Security Basics

- [ ] No hardcoded secrets/keys
- [ ] Environment variables para config sensitiva
- [ ] HTTPS en URLs externas
- [ ] CORS configurado correctamente
- [ ] Authentication/Authorization implementada

### Privacy & Permissions

- [ ] Datos sensitivos no en logs
- [ ] Usuarios solo ven sus datos
- [ ] Role-based access control (RBAC)
- [ ] Audit trail para acciones críticas
- [ ] GDPR/Privacy compliance considerado

### Dependencies

- [ ] No dependencias desconocidas
- [ ] Versions pinned apropiadamente
- [ ] Security updates aplicados
- [ ] License check (GPL, MIT, etc.)
- [ ] Package tree audited (npm audit)

### Code Analysis

- [ ] TypeScript strict mode ON
- [ ] Linter sin warnings
- [ ] Formatter aplicado (Prettier, stylua)
- [ ] Type coverage > 95%
- [ ] No forbidden patterns

### Architecture Layers

- [ ] Lógica de dominio separada
- [ ] Lógica de aplicación orquesta
- [ ] Lógica de empresa en policies
- [ ] Dependencies apuntan adentro
- [ ] Adaptadores mediayen comunicación

---

## 📋 MATRIZ DE CHECKLISTS POR FASE SDD

### sdd-spec Phase
- [ ] Criterios de Aceptación Checklist
- [ ] User Stories + Casos de Uso
- [ ] Security Requirements identificados
- [ ] Test cases preliminares planificados

### sdd-design Phase
- [ ] Architecture security layers
- [ ] Pair programming sessión(s) si arquitectura compleja
- [ ] Test strategy definida (Unit/Integration/E2E)
- [ ] Security design review

### sdd-apply Phase
- [ ] TDD Checklist activo (Red-Green-Refactor)
- [ ] Clean Code Checklist aplicado
- [ ] Testing Checklist en paralelo
- [ ] Pair programming sesiones cuando necesario

### sdd-verify Phase
- [ ] Code Review Checklist ejecutado
- [ ] Definition of Done Checklist completado
- [ ] Security & Quality Gates pasados
- [ ] All tests green

### sdd-archive Phase
- [ ] Todos los checklists completados
- [ ] Documentación finalizada
- [ ] Standards establecidos para futuros proyectos
- [ ] Post-mortem si hay learnings importantes

---

## 🚀 QUICK START TEMPLATE

Para iniciar un nuevo feature/task:

```markdown
## Feature: [Feature Name]

### Criterios de Aceptación
- [ ] Criterio 1
- [ ] Criterio 2
- [ ] Criterio 3

### Aceptación Testing
- [ ] Test 1 - descripción
- [ ] Test 2 - descripción

### Security Requirements
- [ ] Validación de entrada: [descripción]
- [ ] Permisos/Authorization: [descripción]
- [ ] Sensitive data handling: [descripción]

### Design Notes
- Componentes atómicos:
  - [ ] Component A
  - [ ] Component B
- Pair programming requerido: [ ] Sí [ ] No

### TDD Progress
- [ ] RED: Tests escritos
- [ ] GREEN: Código implementado
- [ ] REFACTOR: Mejorado
- [ ] Coverage: __% 

### Code Review Readiness
- [ ] Tipado correcto
- [ ] Nombres revelan intención
- [ ] Funciones < 30 líneas
- [ ] Tests 80%+ coverage
- [ ] Validación implementada

### Ready for Definition of Done
- [ ] Todos checklists completados
- [ ] Code review aprobado
- [ ] Tests en verde
- [ ] Listo para merge
```

---

**Nota**: Estos checklists son guías. Adaptarlos al contexto del proyecto.

**Última actualización**: 2026-03-07
