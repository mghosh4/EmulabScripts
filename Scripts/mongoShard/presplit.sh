use admin;
sh.stopBalancer();
var rs = ["rs0","rs2","rs3","rs1","rs4","rs5","rs6","rs7"];

count = 10000000;
gap = 70000;
for ( var x=gap; x<count; x+=gap ){
    db.adminCommand({split : "amazondb.review_collection", middle : {user_id : x}});
    db.adminCommand({moveChunk : "amazondb.review_collection", find : {user_id : x}, to : rs[Math.floor(Math.random()*rs.length)]})
}
sh.setBalancerState(true)
