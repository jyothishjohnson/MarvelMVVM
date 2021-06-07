//
//  PayRecentExpensesView.swift
//  SwiftUIAnimations
//
//  Created by Jyothish New on 28/05/21.
//

import SwiftUI

struct PayRecentExpensesView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Latest expenses")
                    .font(.title2)
                    .fontWeight(.regular)
                Spacer()
                Text("-$245")
                    .fontWeight(.thin)
            }
            PaySingleExpenseListCellView(expense: Expense.recents.first!)
            PaySingleExpenseListCellView(expense: Expense.recents.last!)
        }
        .padding(.horizontal)
        .padding(.top,20)
    }
}

struct PayRecentExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        PayHome()
    }
}

struct Expense : Identifiable {
    
    let id = UUID()
    let name : String
    let date : String
    let image: String
    let isExpense : Bool
    let amount : Double
    
    static let recents : [Expense] = [
        Expense(name: "Apartment Rent", date: "Feb 20", image: "building.2.fill", isExpense: true, amount: 183.5),
        Expense(name: "Monthly Groceries", date: "Feb 13", image: "cart.fill", isExpense: true, amount: 120.2),
        Expense(name: "Bus Fares", date: "Feb 11", image: "bus.doubledecker", isExpense: true, amount: 54.0),
        Expense(name: "Salary", date: "Feb 5", image: "dollarsign.square.fill", isExpense: false, amount: 1200.0)
    ]
}
