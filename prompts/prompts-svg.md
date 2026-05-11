# Listado de prompts
Opencode modelo Minimax M2.5 Free OpenCode Zen

## Prompt 1 - Análisis esquema actual

```text
Actúa como arquitecto senior de bases de datos PostgreSQL + Prisma.

Analiza EXCLUSIVAMENTE en @backend/prisma/.

Quiero una auditoría técnica profesional con estos bloques:

1. Entidades actuales y relaciones existentes
2. Problemas de diseño detectados
3. Problemas de normalización (1FN, 2FN, 3FN)
4. Índices faltantes o mejorables
5. Riesgos futuros de escalabilidad
6. Mejoras recomendadas sin romper compatibilidad

NO propongas todavía nuevas tablas.
NO generes código.

Solo auditoría del estado actual.
```

---

# Prompt 2 - Análisis ERD

```text
Actúa como analista funcional y arquitecto de bases de datos.

Voy a darte un ERD Mermaid.

Quiero que lo analices SIN compararlo todavía con ninguna base de datos existente.

Necesito 6 bloques:

1. Lista de entidades y propósito de negocio de cada una
2. Relaciones entre entidades y cardinalidades
3. Flujo funcional completo de la aplicación que representa
4. Campos que parecen estados y deberían ser enums
5. Riesgos de diseño detectados en el ERD
6. Mejoras recomendadas aplicando buenas prácticas de normalización e índices

No generes SQL.
No generes Prisma.
No compares aún con schema actual.

Solo análisis del ERD.

````mermaid
erDiagram
     COMPANY {
         int id PK
         string name
     }
     EMPLOYEE {
         int id PK
         int company_id FK
         string name
         string email
         string role
         boolean is_active
     }
     POSITION {
         int id PK
         int company_id FK
         int interview_flow_id FK
         string title
         text description
         string status
         boolean is_visible
         string location
         text job_description
         text requirements
         text responsibilities
         numeric salary_min
         numeric salary_max
         string employment_type
         text benefits
         text company_description
         date application_deadline
         string contact_info
     }
     INTERVIEW_FLOW {
         int id PK
         string description
     }
     INTERVIEW_STEP {
         int id PK
         int interview_flow_id FK
         int interview_type_id FK
         string name
         int order_index
     }
     INTERVIEW_TYPE {
         int id PK
         string name
         text description
     }
     CANDIDATE {
         int id PK
         string firstName
         string lastName
         string email
         string phone
         string address
     }
     APPLICATION {
         int id PK
         int position_id FK
         int candidate_id FK
         date application_date
         string status
         text notes
     }
     INTERVIEW {
         int id PK
         int application_id FK
         int interview_step_id FK
         int employee_id FK
         date interview_date
         string result
         int score
         text notes
     }

     COMPANY ||--o{ EMPLOYEE : employs
     COMPANY ||--o{ POSITION : offers
     POSITION ||--|| INTERVIEW_FLOW : assigns
     INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
     INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
     POSITION ||--o{ APPLICATION : receives
     CANDIDATE ||--o{ APPLICATION : submits
     APPLICATION ||--o{ INTERVIEW : has
     INTERVIEW ||--|| INTERVIEW_STEP : consists_of
     EMPLOYEE ||--o{ INTERVIEW : conducts
     ````
```

---

# Prompt 3 - GAP entre esquema actual y erd

```text
Actúa como arquitecto senior de bases de datos y experto en Prisma migrations.

Voy a darte:

1. schema.prisma actual disponible en @backend/prisma/.
2. ERD Mermaid objetivo
````mermaid
erDiagram
     COMPANY {
         int id PK
         string name
     }
     EMPLOYEE {
         int id PK
         int company_id FK
         string name
         string email
         string role
         boolean is_active
     }
     POSITION {
         int id PK
         int company_id FK
         int interview_flow_id FK
         string title
         text description
         string status
         boolean is_visible
         string location
         text job_description
         text requirements
         text responsibilities
         numeric salary_min
         numeric salary_max
         string employment_type
         text benefits
         text company_description
         date application_deadline
         string contact_info
     }
     INTERVIEW_FLOW {
         int id PK
         string description
     }
     INTERVIEW_STEP {
         int id PK
         int interview_flow_id FK
         int interview_type_id FK
         string name
         int order_index
     }
     INTERVIEW_TYPE {
         int id PK
         string name
         text description
     }
     CANDIDATE {
         int id PK
         string firstName
         string lastName
         string email
         string phone
         string address
     }
     APPLICATION {
         int id PK
         int position_id FK
         int candidate_id FK
         date application_date
         string status
         text notes
     }
     INTERVIEW {
         int id PK
         int application_id FK
         int interview_step_id FK
         int employee_id FK
         date interview_date
         string result
         int score
         text notes
     }

     COMPANY ||--o{ EMPLOYEE : employs
     COMPANY ||--o{ POSITION : offers
     POSITION ||--|| INTERVIEW_FLOW : assigns
     INTERVIEW_FLOW ||--o{ INTERVIEW_STEP : contains
     INTERVIEW_STEP ||--|| INTERVIEW_TYPE : uses
     POSITION ||--o{ APPLICATION : receives
     CANDIDATE ||--o{ APPLICATION : submits
     APPLICATION ||--o{ INTERVIEW : has
     INTERVIEW ||--|| INTERVIEW_STEP : consists_of
     EMPLOYEE ||--o{ INTERVIEW : conducts
     ````


Quiero un GAP Analysis profesional con una tabla de 5 columnas:

1. Entidad del ERD
2. ¿Existe ya en schema actual? (Sí / Parcial / No)
3. Acción recomendada (Reutilizar / Modificar / Crear nueva)
4. Riesgo técnico de migración (Bajo / Medio / Alto)
5. Comentario técnico

Además, al final añade:

6. Orden recomendado de implementación de entidades
7. Riesgos de romper datos existentes
8. Estrategia segura de migración incremental

NO generes código todavía.
NO generes schema.prisma aún.
NO SQL aún.
Solo estrategia.
```

---

# Prompt 4 - Diseño schema final

```text
Actúa como arquitecto senior experto en Prisma + PostgreSQL.

Con el schema.prisma actual y el ERD Mermaid objetivo pasados anteriormente

Quiero que diseñes la ARQUITECTURA del nuevo schema.prisma resultante, expandiendo la base existente para cumplir el ERD.

Devuélveme:

1. Lista final de modelos Prisma
2. Qué modelos actuales se mantienen
3. Qué modelos actuales deben modificarse
4. Qué modelos nuevos deben crearse
5. Relaciones entre modelos (1:1, 1:N, N:M)
6. Enums recomendados
7. Índices recomendados
8. Constraints únicos recomendados
9. Reglas onDelete / onUpdate recomendadas
10. Riesgos de diseño detectados

Aplica buenas prácticas:
- normalización
- rendimiento
- claridad
- escalabilidad
- PostgreSQL + Prisma

NO generes todavía el schema.prisma final.
NO generes migraciones.
NO SQL.

Solo diseño técnico.
```

---

# Prompt 5 - Generar nuevo schema 

```text
Actúa como desarrollador senior experto en Prisma y PostgreSQL.

A partir del schema.prisma actual y el ERD Mermaid objetivo

Necesito que generes el NUEVO schema.prisma completo, expandiendo la base de datos actual para cumplir el ERD.

REQUISITOS IMPORTANTES:

- Mantener las entidades actuales:
  Candidate
  Education
  WorkExperience
  Resume

- Añadir nuevas entidades:
  Company
  Employee
  Position
  InterviewFlow
  InterviewStep
  InterviewType
  Application
  Interview

- Mantener la relación del ERD:
  Position <-> InterviewFlow como 1:1

- No añadir entidades nuevas fuera del ERD
- No añadir tablas audit/history
- No soft delete
- No CompanyStatus
- No LocationType
- No Candidate.companyId
- No fragmentar address
- No features fase 2
- No sobreingeniería

Buenas prácticas obligatorias:

- Enums solo donde aporten valor real
  (Position.status, Application.status, Interview.result, EmploymentType)

- Añadir createdAt y updatedAt en nuevas tablas

- Índices útiles reales

- Constraints únicos importantes:
  Application(positionId, candidateId)
  InterviewStep(interviewFlowId, orderIndex)

- Mantener Candidate.email unique actual

- Tipos Prisma limpios y consistentes

- Relaciones correctas con @relation

- onDelete razonables

ENTREGA:

1. schema.prisma completo
2. Resumen corto de cambios realizados
3. Lista de índices añadidos
4. Lista de enums creados

No generes SQL todavía.
No generes migraciones todavía.

```

---

# Prompt 6 - Corregir esquema

```text
Revisa el schema.prisma generado en el paso anterior como experto senior en Prisma.

Quiero que detectes ERRORES REALES de compilación, relaciones inválidas, claves primarias faltantes, tipos inconsistentes y problemas que romperían `prisma migrate dev`.

Especial atención:

- claves primarias
- tipos FK compatibles
- relaciones 1:1
- backrelations
- índices duplicados
- enums correctos

No me des mejoras opcionales.
Solo errores reales y versión corregida mínima.
No modiques schema.prisma, sigue dándomelo por el chat.

```

---

# Prompt  7 - Revisión schema final

```text
Revisa el schema.prisma final y asegúrate de que todos los modelos usan Int autoincrement como PK salvo que exista una razón técnica fuerte para no hacerlo.
Devuélveme versión final lista para migrate.
```

---

# Prompt 8 - Mejoras del schema

```text
Usa como base el último schema.prisma generado en esta conversación.

Quiero que lo revises y apliques SOLO estas mejoras mínimas antes de escribirlo en el archivo real @backend/prisma/schema.prisma:

1. Corregir formato y alineación Prisma
2. Revisar si hay pequeños errores de sintaxis
3. Verificar relaciones y backrelations
4. Mantener todos los IDs como Int autoincrement
5. No añadir nuevas entidades
6. No cambiar estructura funcional
7. No hacer mejoras opcionales fuera del alcance

Opcional solo si es limpio:
- convertir Employee.role a enum EmployeeRole

Después:
- sobrescribe @backend/prisma/schema.prisma
- muéstrame resumen exacto de cambios realizados

No ejecutes migraciones todavía.
No toques otros archivos.
```

---

# Prompt 9 - Corrección revisión pr 

```text
In `@backend/prisma/schema.prisma` around lines 128 - 129, Add a DB-level CHECK
constraint to enforce salaryMin <= salaryMax for the Position model by appending
an idempotent raw SQL block to the migration: add an ALTER TABLE "Position" ...
ADD CONSTRAINT "Position_salary_range_chk" CHECK ("salaryMin" IS NULL OR
"salaryMax" IS NULL OR "salaryMin" <= "salaryMax"); ensure the migration is safe
to re-run by guarding the add (use a conditional or database-specific IF NOT
EXISTS pattern) so the constraint name Position_salary_range_chk is used
consistently and prevents inverted salary ranges at the DB level.
```

---

# Prompt  10 - Corrección revisión pr

```text
IIn `@backend/prisma/schema.prisma` around lines 89 - 94, Add createdAt and
updatedAt timestamp fields to the InterviewType model in schema.prisma to match
other models: declare createdAt DateTime `@default`(now()) and updatedAt DateTime
`@updatedAt`; update the InterviewType model (symbol: InterviewType) to include
these fields alongside id, name, description, and interviewSteps, and then
generate/apply a follow-up migration to add these two columns to the existing
InterviewType table in the database.
```

---

# Prompt 11 - 

```text
In `@backend/prisma/schema.prisma` around lines 139 - 140, The Position model's
optional field interviewFlowId currently uses Prisma's default ON DELETE SET
NULL behavior and should be changed to a restrictive referential action; update
the InterviewFlow relation on the Position model (the interviewFlow /
interviewFlowId relation) to include an explicit `@relation`(..., onDelete:
Restrict) (or onDelete: NoAction) so deleting an InterviewFlow will be blocked
while Positions reference it, matching companyId's behavior; after changing the
`@relation`, run prisma migrate/dev to generate the migration and verify the
generated SQL uses RESTRICT/NO ACTION instead of SET NULL.
```

---

