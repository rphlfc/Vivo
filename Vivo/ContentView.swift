//
//  ContentView.swift
//  Vivo
//
//  Created by Raphael Cerqueira on 05/06/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 0) {
                GeometryReader { reader in
                    if (reader.frame(in: .global).minY > 0) {
                        HeaderView()
                            .frame(width: reader.size.width, height: reader.size.height + reader.frame(in: .global).minY)
                            .offset(y: -reader.frame(in: .global).minY)
                    } else {
                        HeaderView()
                    }
                }
                .frame(height: 460)
                
                VStack(alignment: .leading, spacing: 0) {
                    ListView(title: "Lista de contas", items: contasItems)
                    
                    ListRowView(item: ListItem(title: "Ver mais contas", image: "plus"))
                    
                    ListView(title: "Mais opções", items: optionsItems)
                        .padding(.top, 40)
                    
                    ListView(title: "Configurações de pagamento", items: configItems)
                        .padding(.top, 40)
                }
                .padding(.top, 40)
                .background(Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.956749022, alpha: 1)))
            }
        })
        .edgesIgnoringSafeArea(.top)
    }
}

struct ListView: View {
    var title: String
    var items: [ListItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title.uppercased())
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .fontWeight(.bold)
                .padding(.leading)
                .padding(.bottom)
                
            
            ForEach(items) { item in
                ListRowView(item: item)
            }
        }
    }
}

struct ListItem: Identifiable {
    let id = UUID().uuidString
    var title: String
    var subtitle: Text?
    var value: String?
    var image = "chevron.right"
}

let contasItems = [
    ListItem(title: "Junho", subtitle: Text("aberta").foregroundColor(.orange), value: "R$ 172,49"),
    ListItem(title: "Maio", subtitle: Text("aberta").foregroundColor(.green), value: "R$ 172,49"),
    ListItem(title: "Abril", subtitle: Text("aberta").foregroundColor(.green), value: "R$ 172,49"),
]

let optionsItems = [
    ListItem(title: "Ver acordos"),
    ListItem(title: "Informar pagamento")
]

let configItems = [
    ListItem(title: "Conta Digital", subtitle: Text("ativado").foregroundColor(.gray).fontWeight(.semibold)),
    ListItem(title: "Pagar com cartão", subtitle: Text("Cadastrar cartão").foregroundColor(.gray).fontWeight(.semibold)),
    ListItem(title: "Débito automático", subtitle: Text("desativado").foregroundColor(.gray).fontWeight(.semibold)),
    ListItem(title: "Vencimento", subtitle: Text("dia 15").foregroundColor(.gray).fontWeight(.semibold)),
]

struct ListRowView: View {
    var item: ListItem
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.title)
                    
                    if let subtitle = item.subtitle {
                        subtitle
                    }
                }
                
                Spacer()
                
                if let value = item.value {
                    Text(value)
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                
                Image(systemName: item.image)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Divider()
        }
        .background(Color.white)
    }
}

struct MenuItem: Identifiable {
    let id = UUID().uuidString
    var image: String
    var title: String
}

let menuData = [
    MenuItem(image: "barcode", title: "Código de barras"),
    MenuItem(image: "doc", title: "2 via de conta"),
    MenuItem(image: "creditcard", title: "Pagar com cartão"),
    MenuItem(image: "envelope", title: "Enviar por email"),
    MenuItem(image: "magnifyingglass", title: "Negociar conta")
]

struct HeaderView: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.9775968194, green: 0.3932468593, blue: 0.1376122236, alpha: 1))
            
            VStack(alignment: .leading, spacing: 40) {
                Spacer(minLength: 0)
                
                Text("Conta aberta")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)
                
                Text("Sua conta de Junho,\nno valor de R$ 172,46\nvence no dia 15/06")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(menuData) { item in
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 140, height: 140)
                                .foregroundColor(.white)
                                .overlay(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Image(systemName: item.image)
                                                .font(.title)
                                                .foregroundColor(.gray)
                                            
                                            Spacer()
                                            
                                            Text(item.title)
                                                .font(.title2)
                                                .fontWeight(.medium)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(8)
                            )
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .padding(.top, 20)
            }
            .padding(.vertical)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
