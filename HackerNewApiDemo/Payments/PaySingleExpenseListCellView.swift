//
//  PaySingleExpenseListCellView.swift
//  SwiftUIAnimations
//
//  Created by Jyothish New on 28/05/21.
//

import SwiftUI

struct PaySingleExpenseListCellView: View {
    
    let expense : Expense
    
    var body: some View {
        HStack{
            Image(systemName: expense.image)
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
                .padding(4)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(14)
            
            VStack(alignment: .leading){
                
                Text(expense.name)
                    .font(.title3)
                    .fontWeight(.regular)
                    .padding(.top,4)
                
                Spacer()

                Text(expense.date)
                    .font(.callout)
                    .fontWeight(.thin)
                    .padding(.bottom,4)

            }
            .padding(.leading,8)
                
            Spacer()
            
            if expense.isExpense {
                Text(String(format: "-$%.1f", arguments: [expense.amount]))
                    .font(.title3)
                    .foregroundColor(.red.opacity(0.8))
            }else {
                Text(String(format: "$%.1f", arguments: [expense.amount]))
                    .font(.title3)
                    .foregroundColor(.green.opacity(0.8))
            }
               
        }
        .frame(height: 64)
        .padding(.top)
    }
}

struct PaySingleExpenseListCellView_Previews: PreviewProvider {
    static var previews: some View {
        PayHome()
    }
}
