-- OpenCode.nvim: Configuración del Arquitecto Asistente para Statick
-- Basado en Clean Architecture, Principios SOLID, TDD, Patrones de Diseño
return {
  prompts = {
    separation_of_concerns = "🤖 Analizo este código aplicando el Principio de Separación de Preocupaciones. Capa de Dominio, Capa de Aplicación, Capa de Infraestructura. Violaciones detectadas y sugerencias de separación. 👤 Statick, ¿quieres que proceda con la separación de capas o necesitas explorar otras opciones arquitectónicas?",

    domain_independence = "🤖 Evalúo la Independencia del Dominio según Clean Architecture. Dominio puro, dependencias externas, riesgos de acoplamiento, métricas de independencia y recomendaciones arquitectónicas. 👤 Statick, como arquitecto principal, ¿qué dirección arquitectónica prefieres seguir?",

    solid_principles = "🤖 Evalúo el cumplimiento de Principios SOLID. S-Single Responsibility, O-Open/Closed, L-Liskov Substitution, I-Interface Segregation, D-Dependency Inversion. Calificación general y problemas prioritarios. 👤 Statick, qué principio requiere atención inmediata o necesitas asistencia con patrones específicos?",

    design_patterns = "🤖 Identifico oportunidades para Patrones de Diseño según Clean Architecture. Factory Pattern, Repository Pattern, Observer Pattern, Strategy Pattern, Adapter Pattern. Implementación sugerida. 👤 Statick, prefieres implementar algún patrón específico o necesitas explore alternativas?",

    behavior_testing = "🤖 Sigo el principio de Testing de Comportamientos. Comportamientos actuales, tests existentes, tests de comportamiento faltantes, cobertura de comportamientos y estrategia de testing sugerida. 👤 Statick, qué estrategia de testing prefieres implementar o necesitas asistencia con escenarios específicos?",

    immutability = "🤖 Analizo el código según principios de inmutabilidad. Estado mutable detectado, riesgos de concurrencia, sugerencias inmutables, implementación funcional y estado predecible. 👤 Statick, prefieres enfoque inmutable, funcional, o mantener mutable con controles adicionales?",

    hexagonal_architecture = "🤖 Diseño de Arquitectura Hexagonal. Puertos del Dominio, Adaptadores de Infraestructura, Casos de Uso, Comunicación puertos-adaptadores y Testing de contratos. 👤 Statick, como arquitecto principal, ¿qué adaptadores quieres implementar o necesitas asistencia con diseño de puertos?"
  },

  ui = {
    show_line_numbers = true,
    show_cursor_line = true,
    wrap_lines = false,
    theme = "matrix",
    show_quality_metrics = true,
    show_principle_violations = true,
    auto_format_on_save = true,

    identity_display = {
      robot_prefix = "🤖",
      statick_prefix = "👤",
      clear_visual_distinction = true,
      show_decision_authority = true
    }
  },

  agents = {
    sisyphus = {
      model = "gemini-2.5-pro",
      role = "architectural_orchestrator",
      specialization = "task_delegation",
      expertise = "clean_architecture_principles",
      temperature = 0.7,
      description = "Arquitecto principal - Gemini 2.5 Pro para decisiones complejas"
    },

    oracle = {
      model = "gemini-2.5-pro",
      role = "clean_architecture_expert",
      specialization = "code_review_principles",
      expertise = "solid_principles_design_patterns",
      temperature = 0.3,
      description = "Experto en Clean Architecture - análisis de código y patrones"
    },

    librarian = {
      model = "gemini-2.5-flash",
      role = "documentation_specialist",
      specialization = "technical_documentation",
      expertise = "ieee_acm_standards",
      temperature = 0.5,
      description = "Especialista en documentación - Gemini 2.5 Flash"
    },

    frontend = {
      model = "gemini-2.5-flash",
      role = "ui_ux_developer",
      specialization = "statick_ui_patterns",
      expertise = "react_modern_patterns",
      temperature = 0.6,
      description = "Especialista en UI/UX - Gemini 2.5 Flash"
    }
  },

  hexagonal_architecture = {
    domain_port = {
      interface = "DomainPort",
      methods = {"execute_use_case", "validate_business_rules", "get_domain_events"},
      description = "Interfaz para lógica de negocio pura"
    },

    adapters = {
      database = {
        implements = "DomainPort",
        technology = "PostgreSQL/MongoDB",
        methods = {"save", "findById", "update", "delete"},
        pattern = "repository_pattern"
      },

      web_api = {
        implements = "DomainPort",
        technology = "REST/GraphQL",
        methods = {"handleRequest", "sendResponse", "validateInput"},
        pattern = "adapter_pattern"
      },

      message_queue = {
        implements = "DomainPort",
        technology = "Redis/RabbitMQ",
        methods = {"publish", "subscribe", "processMessage"},
        pattern = "observer_pattern"
      }
    },

    use_cases = {
      create_entity = "CreateEntityUseCase",
      update_entity = "UpdateEntityUseCase",
      process_order = "ProcessOrderUseCase",
      generate_report = "GenerateReportUseCase"
    },

    testing_strategy = {
      unit_tests = "Test de cada caso de uso en aislamiento",
      integration_tests = "Test de adaptadores con servicios externos",
      behavior_tests = "Test de escenarios completos del negocio",
      contract_tests = "Test de contratos entre puertos y adaptadores"
    }
  }
}
