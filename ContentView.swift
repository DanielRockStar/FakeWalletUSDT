import SwiftUI

struct ContentView: View {
    @State private var balance: Double = 1000.00 // Начальный баланс
    @State private var transactions: [Transaction] = []
    @State private var showingAddTransaction = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Баланс: \(balance, specifier: "%.2f") USDT")
                    .font(.largeTitle)
                    .padding()
                
                List(transactions) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.type.rawValue)
                                .font(.headline)
                            Text(transaction.date, style: .date)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("\(transaction.amount, specifier: "%.2f") USDT")
                            .foregroundColor(transaction.type == .deposit ? .green : .red)
                    }
                }
                
                Button("Добавить транзакцию") {
                    showingAddTransaction = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .sheet(isPresented: $showingAddTransaction) {
                    AddTransactionView(balance: $balance, transactions: $transactions)
                }
            }
            .navigationTitle("Фейковый Кошелек")
        }
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let date: Date
}

enum TransactionType: String {
    case deposit = "Пополнение"
    case withdrawal = "Вывод"
}

struct AddTransactionView: View {
    @Binding var balance: Double
    @Binding var transactions: [Transaction]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var amount: String = ""
    @State private var type: TransactionType = .deposit
    
    var body: some View {
        VStack {
            Text("Добавить Транзакцию")
                .font(.title)
                .padding()
            
            TextField("Сумма", text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            
            Picker("Тип", selection: $type) {
                Text("Пополнение").tag(TransactionType.deposit)
                Text("Вывод").tag(TransactionType.withdrawal)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Добавить") {
                if let amountValue = Double(amount) {
                    let transaction = Transaction(type: type, amount: amountValue, date: Date())
                    transactions.insert(transaction, at: 0)
                    balance += type == .deposit ? amountValue : -amountValue
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

@main
struct FakeWalletApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
