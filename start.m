dimenze = 2;

% načíst dataset
jmenoSouboru = 'Zakaznici.csv';
dataset = readmatrix(jmenoSouboru,'Range','D2:E10000');

% minimální vzdálenost
vzdalenosti = zeros(200,1);

for a = 1:200
    vysledek = 1000000000;
    for b = 1:200
        if (a ~= b)
          vypocet = sqrt( ((dataset(b,1)-dataset(a,1))^2) + ((dataset(b,2)-dataset(a,2))^2) );
          if (vysledek > vypocet)
              vysledek = vypocet;
          end
        end
    end
    vzdalenosti(a,1) = vysledek;
end
f=figure('PaperOrientation','landscape');
plot(1:200,sort(vzdalenosti))
title('Graf minimálních vzdáleností seřazený podle velikosti');
xlabel( 'Zákazník' );
ylabel( 'Vzdálenost' );
saveas(f,'graf_min_vzdalenosti.pdf');


% graf hodnot v datasetu
f=figure('PaperOrientation','landscape');
scatter(dataset(:,1),dataset(:,2));
title('Graf funkce měšíčního příjmu a indexu útraty zákazníka');
xlabel( 'Roční příjem' );
ylabel( 'Index útraty (1-100)' );
saveas(f,'graf_bez_skupin.pdf');


% clastering pomocí funkce DBSCAN
eps = 7;
minBodu = dimenze * 2;
skupina = dbscan(dataset,eps,minBodu);

f=figure('PaperOrientation','landscape');
gscatter(dataset(:,1),dataset(:,2),skupina);
title('Graf rozdělený do skupin v závislosti na Euklidovské vzdálenosti');
xlabel( 'Roční příjem' );
ylabel( 'Index útraty (1-100)' );
saveas(f,'graf_skupiny.pdf');