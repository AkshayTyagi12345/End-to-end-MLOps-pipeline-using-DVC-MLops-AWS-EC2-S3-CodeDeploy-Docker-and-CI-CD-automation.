GitHub Push
     │
     ▼
Checkout Code
     │
     ▼
Setup Python
     │
     ▼
Cache pip dependencies
     │
     ▼
Install Dependencies (pip install -r requirements.txt)
     │
     ▼
Run DVC Pipeline (dvc repro)
     │
     ├────────────▶ DVC DAG:
     │                ┌───────────────┐
     │                │ data_ingestion │
     │                └──────┬────────┘
     │                       ▼
     │                ┌───────────────┐
     │                │ data_preprocessing │
     │                └──────┬────────┘
     │                       ▼
     │                ┌───────────────┐
     │                │ feature_engineering │
     │                └──────┬────────┘
     │                       ▼
     │                ┌───────────────┐
     │                │ model_training │
     │                └──────┬────────┘
     │                       ▼
     │                ┌───────────────┐
     │                │ model_evaluation │
     │                └──────┬────────┘
     │                       ▼
     │                ┌───────────────┐
     │                │ model_registration │
     │                └───────────────┘
     │
     ▼
Run Model Tests
     │
     ▼
Run Flask App Tests
     │
     ▼
Build & Push Docker Image to AWS ECR
     ├──► aws ecr login
     ├──► docker build
     ├──► docker tag
     └──► docker push
     │
     ▼
Zip Deployment Files (appspec.yml + scripts)
     │
     ▼
Upload ZIP to S3
     │
     ▼
Trigger AWS CodeDeploy
     │
     ▼
  EC2 Instance (via CodeDeploy)
     │
     ├──► install_dependencies.sh
     │     ├─ apt update
     │     ├─ install docker, unzip, curl
     │     ├─ install aws cli
     │     └─ add ubuntu to docker group
     │
     └──► start_docker.sh
           ├─ aws ecr login
           ├─ docker pull latest
           ├─ stop/remove old container
           └─ docker run new container (port 80:5000)
