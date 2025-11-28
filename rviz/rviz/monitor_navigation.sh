#!/bin/bash
echo "=== МОНИТОРИНГ СИСТЕМЫ НАВИГАЦИИ ==="
echo ""

echo "1. СТАТУС MOVE_BASE:"
rostopic echo /move_base/status -n 1 | grep -A 5 "status:" 

echo ""
echo "2. ЧАСТОТА ОБНОВЛЕНИЙ:"
echo "   Global Costmap:"
rostopic hz /move_base/global_costmap/costmap_updates | head -3 &
echo "   Local Costmap:"
rostopic hz /move_base/local_costmap/costmap_updates | head -3 &

echo ""
echo "3. КОМАНДЫ СКОРОСТИ:"
rostopic echo /cmd_vel -n 1 | grep -E "(linear|angular)"

echo ""
echo "4. ПУТИ:"
echo "   Global Path точек:" $(rostopic echo /move_base/NavfnROS/plan -n 1 | grep "points" | wc -l)
echo "   Local Path точек:" $(rostopic echo /move_base/DWAPlannerROS/local_plan -n 1 | grep "points" | wc -l)

echo ""
echo "Для выхода нажмите Ctrl+C"
wait 
