-- Paramètres de la session Hive
-- À exécuter avant les chargements RAW -> REFINED

-- Exécution parallèle des jobs Hive indépendants
SET hive.exec.parallel=true;
SET hive.exec.parallel.thread.number=2;

-- Partitions dynamiques
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

SET hive.exec.max.dynamic.partitions=1000;
SET hive.exec.max.dynamic.partitions.pernode=500;

-- Respect du bucketing lors des insertions
SET hive.enforce.bucketing=true;

-- Mémoire des reducers MapReduce
SET mapreduce.map.memory.mb=1024;
SET mapreduce.reduce.memory.mb=1024;
SET mapreduce.map.java.opts=-Djava.net.preferIPv4Stack=true -Xmx768m;
SET mapreduce.reduce.java.opts=-Djava.net.preferIPv4Stack=true -Xmx768m;

SET hive.auto.convert.join=false;
