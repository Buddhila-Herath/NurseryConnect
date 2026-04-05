import SwiftUI

struct ChildRow: View {
    let child: Child
    let hasAlert: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            Text(child.avatar)
                .font(.system(size: 40))
                .padding(10)
                .background(Circle().fill(Color.gray.opacity(0.1)))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(child.name)
                    .font(.headline)
                
                Text("\(child.age) years old")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if !child.allergies.isEmpty {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.red)
                    .font(.title3)
            }
            
            if hasAlert {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .overlay(
                        Circle()
                            .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                            .scaleEffect(1.5)
                    )
            }
        }
        .padding(.vertical, 8)
    }
}
