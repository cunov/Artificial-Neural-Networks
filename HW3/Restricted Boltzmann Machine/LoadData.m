function datFin = LoadData()
dat{1} = -1 * ones(3,3);
dat{2} = -1 * ones(3,3); dat{2}(:,1) = -1 * dat{2}(:,1);
dat{3} = -1 * ones(3,3); dat{3}(:,2) = -1 * dat{3}(:,2);
dat{4} = -1 * ones(3,3); dat{4}(:,3) = -1 * dat{4}(:,3);
dat{5} = ones(3,3); dat{5}(:,3) = -1 * dat{5}(:,3);
dat{6} = ones(3,3); dat{6}(:,1) = -1 * dat{6}(:,1);
dat{7} = ones(3,3); dat{7}(:,2) = -1 * dat{7}(:,2);
dat{8} = ones(3,3);
dat{9} = -1 * ones(3,3); dat{9}(1,:) = -1 * dat{9}(1,:);
dat{10} = -1 * ones(3,3); dat{10}(2,:) = -1 * dat{10}(2,:);
dat{11} = -1 * ones(3,3); dat{11}(3,:) = -1 * dat{11}(3,:);
dat{12} = ones(3,3); dat{12}(3,:) = -1 * dat{12}(3,:);
dat{13} = ones(3,3); dat{13}(1,:) = -1 * dat{13}(1,:);
dat{14} = ones(3,3); dat{14}(2,:) = -1 * dat{14}(2,:);
for i = 1:14
    datFin(i,:) = reshape(dat{i},9,1);
end
end

