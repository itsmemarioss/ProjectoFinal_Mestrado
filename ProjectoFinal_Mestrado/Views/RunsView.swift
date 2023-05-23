//
//  ContentView.swift
//  Test
//
//  Created by Aluno ISTEC on 22/05/2023.
//

import SwiftUI
import CoreData

struct RunsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RunEntity.elapsedTime, ascending: true)],
        animation: .default)
    private var items: FetchedResults<RunEntity>

    var body: some View {
        
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Elapsed time: \(item.elapsedTime!)")
                        Text("Avg Speed: \(item.avgSpeed)")
                        Text("Distance: \(item.distance)")
                        Text("Calories: \(item.calories)")
                    } label: {
                        Text(String(format: "Distance: %.2f", item.distance))
                        Text(item.elapsedTime!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


struct RunsView_Previews: PreviewProvider {
    static var previews: some View {
        RunsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
