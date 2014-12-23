use admin;
sh.stopBalancer();
var rs = ["rs0","rs2","rs3","rs1","rs4","rs5","rs6","rs7","rs8","rs9","rs10","rs11","rs12","rs13","rs14","rs15","rs16","rs17","rs18","rs19","rs20","rs21","rs22","rs23","rs24","rs25","rs26","rs27","rs28","rs29","rs30","rs31","rs32"];

count = 40000000;
gap = 70000;
for ( var x=gap; x<count; x+=gap ){
    db.adminCommand({split : "amazondb.review_collection", middle : {user_id : x}});
    db.adminCommand({moveChunk : "amazondb.review_collection", find : {user_id : x}, to : rs[Math.floor(Math.random()*rs.length)]})
}
sh.setBalancerState(true)
