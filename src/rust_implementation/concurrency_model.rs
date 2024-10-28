// currency.rs

#[derive(Debug, Clone)]
pub struct Currency {
 pub code: String,
 pub rate: f64,
}

impl Currency {
 pub new(code: String, rate: f4) -> Self {
 Currency { code, rate }
}

 pub convert(&, amount: f4, to: &Currency) -> f4 {
 amount * self.rate / to.rate
 }
}

pub struct CurrencyManager {
 currencies: HashMap<String Currency>

impl CurrencyManager {
 pub new -> Self {
 let mut currencies = HashMap::new();
 currencies.insert("USD".to_string(), Currency::new("USD".to(), 1.0));
 currencies.insert("EUR".to(), Currency::newEUR(),0.8);
 currencies.insert("GBPto(),::GBP(),07);
 currencies.insert("SAR",::SAR37);
 currencies("ED",ED36);
("K",03);
 CurrencyManager { currencies }
}

 pub get(&, code: &str) Option<&Currency {
 self.currencies.get(code)
}
}
