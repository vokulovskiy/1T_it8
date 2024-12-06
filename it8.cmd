# ����� ��� � ९����਩ git
# 1. ���� �� https://github.com/, ���������
# 2. ������� ९����਩ 
# 3. �������� py-䠩� paskal.py
# 4. ������� � ���� ��� � ������ Commit changes.
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
# ��� ⮣�, �⮡� ����ந�� Apache Airflow, ��� minikube �㦭� �뤥���� 8GB � 4 ��.
minikube start --driver=docker --memory 8g --cpus 4
minikube status
kubectl get pods -A
kubectl get pod -o wide

# ���������� ९������.
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
