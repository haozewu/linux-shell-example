select xx* from root.xx1.xx2.`0xx`.xx4 # 在0.13.0版本中，凡是为0打头的路径，都要加反引号

select count(status), max_value(temperature) from root.ln.wf01.wt01 group by ([2017-11-01T00:00:00, 2017-11-07T23:00:00),1d);

