clear
close all
clc

% 起始值
uint64 i;
Cost = int64(16);
for i = 1 : 16
    Cost(i) = 0;
end

%第一次投注
Cost(1) = 2;
fprintf('第1次投1注，花费2元\r\n');

% 循环计算
for i = 2: 15
    % 计算前面的成本总和
    int64 sum;
    uint64 j;
    sum = 0;
    for j = 1 : i - 1
        sum = sum + Cost(j);
    end
    % 计算最低投注数
    int64 T;
    T = ceil(sum / 5);
    % 保证收益求解投注数
    int64 t;
    t = T;
    while t * 5 < sum + t * 2
        t = t + 1
    end
    Cost(i) = 2 * t;
    fprintf('第%d次投%d注，花费%d元，收益%d元\r\n',i, t, Cost(i), t * 5);
end

