-- Paramètres de la session Hive
-- À exécuter avant les chargements RAW -> REFINED

-- Exécution parallèle des jobs Hive indépendants
SET hive.exec.parallel=true;
SET hive.exec.parallel.thread.number=2;

-- Partitions dynamiques
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

-- Respect du bucketing lors des insertions
SET hive.enforce.bucketing=true;

-- Mémoire des reducers MapReduce
SET mapreduce.reduce.memory.mb=1024;
SET mapreduce.reduce.java.opts=-Djava.net.preferIPv4Stack=true -Xmx768m;
