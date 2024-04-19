pay(First, Last, Pay) :- salaried(First, Last, Salary),
    Pay is Salary.

pay(First, Last, Pay) :- commission(First, Last, MinPay, Sales, CommissionRate),
    Sales * CommissionRate > MinPay,
    Pay is Sales * CommissionRate.

pay(First, Last, Pay) :- commission(First, Last, MinPay, Sales, CommissionRate),
    Sales > 0,
    Sales * CommissionRate =< MinPay,
    Pay is MinPay.

pay(First, Last, Pay) :- hourly(First, Last, Hours, Rate),
    Hours =< 40,
    Pay is Hours * Rate.

pay(First, Last, Pay) :- hourly(First, Last, Hours, Rate),
    Hours > 40,
    Hours =< 50,
    OvertimeHours is Hours - 40,
    Pay is 40 * Rate + OvertimeHours * Rate * 1.5.

pay(First, Last, Pay) :- hourly(First, Last, Hours, Rate),
    Hours > 50,
    OvertimeHours is Hours - 50,
    Pay is 40 * Rate + 10 * Rate * 1.5 + OvertimeHours * Rate * 2.