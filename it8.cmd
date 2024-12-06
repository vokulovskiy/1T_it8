# ложим код в репозиторий git
# 1. Идем на https://github.com/, логинимся
# 2. Создаем репозиторий 
# 3. Создадим py-файл paskal.py
# 4. Добавим в него код и нажмем Commit changes.
#################### EmptyDAG.py ####################################
from airflow import DAG
from airflow.operators.empty import EmptyOperator
from datetime import datetime

default_args = {
'owner': 'airflow',
'depends_on_past': False,
'start_date': datetime(2024, 12, 5, 9, 45),
'email_on_failure': False,
'email_on_retry': False,
}

dag = DAG(
'example_dag',
default_args=default_args,
description='A simple tutorial DAG',
schedule=None,
)

t1 = EmptyOperator(
task_id='dummy_task',
retries=3,
dag=dag,
)
######################################################################
# Для того, чтобы настроить Apache Airflow, для minikube нужно выделить 8GB и 4 ядра.
minikube start --driver=docker --memory 8g --cpus 4
minikube status
kubectl get pods -A
kubectl get pod -o wide

# добавление репозитория.
helm repo add apache-airflow https://airflow.apache.org
helm repo update

helm install airflow apache-airflow/airflow \
--debug \
--namespace airflow \
--create-namespace \
--set dags.gitSync.enabled=true \
--set dags.gitSync.repo=https://github.com/vokulovskiy/1t_672.git \
--set dags.gitSync.branch=main \
--set dags.gitSync.subPath="/"

kubectl get pods -n airflow
kubectl get svc
kubectl port-forward svc/airflow-webserver 8888:8080 --namespace airflow
