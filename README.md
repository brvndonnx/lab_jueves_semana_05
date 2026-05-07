# lab_jueves_semana_05
# Laboratorio Semana 05: Arquitectura de Procesamiento de Imágenes (Dev)
Se despliega una infraestructura orientada a eventos en AWS utilizando Terraform, integrando API Gateway, Lambda, SQS y S3 dentro de una VPC
## Estructura Modular del Proyecto
` ` `.
├── infra/                          # Infraestructura como Código (Terraform)
│   ├── modules/                    # Módulos reutilizables y desacoplados
│   │   ├── vpc/                    # Networking: VPC, Subnets, IGW, NAT Gateway
│   │   │   ├── main.tf             
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── iam/                    # Seguridad: Roles, Policies y Trust Relationships
│   │   │   ├── main.tf             
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── lambda/                 # Compute: Configuración de AWS Lambda y Triggers
│   │   │   ├── main.tf             
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── s3/                     # Storage: Buckets y Estructura de Carpetas
│   │   │   ├── main.tf             
│   │   │   └── variables.tf
│   │   └── sqs/                    # Messaging: Colas de Mensajería y DLQ
│   │       ├── main.tf             
│   │       └── variables.tf
│   └── envs/                       # Orquestación por Entornos
│       ├── dev/                    # Entorno de Desarrollo (Trujillo-LAB)
│       │   ├── main.tf             
│       │   ├── variables.tf        
│       │   ├── terraform.tfvars    
│       │   └── outputs.tf          
│       ├── prod/                   # Entorno de Producción
│       └── qa/                     # Entorno de Calidad
└── src/                            # Lógica de Negocio (Source Code)
    ├── upload-lambda/              # Microservicio: Ingesta de Datos
    │   └── index.mjs               # Decodificación Base64 y Trigger SQS
    └── process-lambda/             # Microservicio: Procesamiento de Imágenes
        └── index.mjs               # Transformación y Registro Final` ` `
## 1. Herramientas
* **Infraestructura:** AWS (VPC, S3, SQS, IAM, API Gateway, Lambda, CloudWatch)
* **IaC:** Terraform 
* **Lenguaje:** Node.js
* **Terminal:** Git Bash (entorno MINGW64).
* **Gestión de Identidad:** AWS CLI
### 2. Preparación del entorno
Navegue a la carpeta del entorno de desarrollo e inicialice los proveedores:
En el bash:
cd infra/envs/dev
terraform init
### 3. Ejecución del despliegue
Cree la infraestructura definida en los archivos .tf
terraform apply -auto-approve
### 4. Prueba de validación
#### 1. Convertí la imagen a formato base64
IMAGEN_BASE64=$(base64 -w 0 test.jpg)

#### 2. Se envía la petición al API Gateway
curl -X POST https://shx4ev720f.execute-api.us-east-1.amazonaws.com/upload \
-H "Content-Type: application/json" \
-d "{
  \"fileName\": \"test.jpg\",
  \"fileContent\": \"$IMAGEN_BASE64\",
  \"contentType\": \"image/jpeg\"
}"
### 5. Destrucción
terraform destroy -auto-approve
