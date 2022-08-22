### 1.根据经纬度计算距离

```mysql
mysql> SELECT ST_Distance_Sphere(ST_GeomFromText('POINT(120.26457 30.18534)'), ST_GeomFromText('POINT(120.2428550 30.2035350)')) distance;
+--------------------+
| distance           |
+--------------------+
| 2906.6838888890456 |
+--------------------+
1 row in set (0.01 sec)
```

