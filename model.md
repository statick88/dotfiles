# Reglas de Desarrollo

## Clean Architecture
- Separación clara de capas: dominio, aplicación, infraestructura
- Dependencias hacia adentro (núcleo no depende de detalles)
- Enterprise Business Rules en el centro
- Independencia de frameworks y librerías externas

## Clean Code
- Nombres significativos que revelan intención
- Funciones pequeñas que hacen una sola cosa
- Evitar argumentos bandera
- Sin duplicación (DRY)
- Comentarios solo cuando necesario, el código debe ser autoexplicativo
- Manejo de errores explícito y apropiado
- Pruebas unitarias y de integración
- Formateo consistente del código

## Principios SOLID
- **S** - Single Responsibility Principle: Cada clase tiene una única responsabilidad
- **O** - Open/Closed Principle: Abierto para extensión, cerrado para modificación
- **L** - Liskov Substitution Principle: Subtipos deben ser sustituibles por sus tipos base
- **I** - Interface Segregation Principle: Interfaces específicas, no generales
- **D** - Dependency Inversion Principle: Depender de abstracciones, no de concreciones

## DevSecOps
- Integración continua de seguridad en el ciclo de desarrollo
- Scanning de vulnerabilidades en dependencias
- Análisis estático de código (SAST)
- Testing dinámico de seguridad (DAST)
- Gestión de secretos y credenciales segura
- Infraestructura segura por diseño
- Monitoreo y alertas de seguridad
- Compliance automatizado

## DevOps
- CI/CD automatizado
- Infrastructure as Code (IaC)
- Monitorización y logging centralizado
- Orquestación de contenedores
- Gestión de configuración
- Rollback automatizado
- Feature flags y deployment strategies
- Observabilidad completa (métricas, logs, traces)

## TDD (Test Driven Development)
- Red - escribir test que falla
- Green - escribir código mínimo para pasar el test
- Refactor - mejorar el código manteniendo tests verdes
- Tests unitarios, integración y e2e
- Mocks y stubs cuando es necesario
- Coverage de código adecuado
- Tests rápidos y confiables

## Refactorización
- Extraer método/variable/clase
- Renombrar para claridad
- Eliminar código muerto
- Simplificar condiciones complejas
- Reducir duplicación
- Aplicar patrones de diseño apropiados
- Mantener tests verdes durante refactor
- Commits pequeños y frecuentes

## Buenas Prácticas
- Code review obligatorio
- Commits atómicos con mensajes descriptivos
- Branch protection en branches principales
- Versionado semántico (SemVer)
- Documentación de código y API
- Linting y formateo automatizado
- Type checking (cuando aplica)
- Performance testing para código crítico
- Accessibility (a11y) en interfaces
- Responsive design en front-end
- Error boundaries y graceful degradation
- Caching apropiado
- Rate limiting y throttling
- Timeout handling
- Circuit breakers para servicios externos
- Idempotencia en operaciones
- Eventual consistency donde aplica
