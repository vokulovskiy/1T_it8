from airflow import DAG
from airflow.operators.empty import EmptyOperator
from datetime import datetime

default_args = {
'owner': 'airflow',
'depends_on_past': False,
'start_date': datetime(2024, 12, 6),
'email_on_failure': False,
'email_on_retry': False,
}

dag = DAG(
dag_id='EmptyDAG',
default_args=default_args,
description='A simple tutorial DAG',
schedule_interval='45 9 * * * ',
catchup=False
)

t1 = EmptyOperator(
task_id='dummy_task',
retries=3,
dag=dag,
)