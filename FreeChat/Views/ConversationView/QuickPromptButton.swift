//
//  QuickPromptButton.swift
//  FreeChat
//
//  Created by Peter Sugihara on 9/4/23.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
  @State var hovered = false
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(hovered ? .body.bold() : .body)
      .background(
        Capsule()
          .strokeBorder(Color.primary.opacity(0.2), lineWidth: 1)
          .foregroundColor(Color.primary)
          .background(hovered ? Color.secondary.opacity(0.05) : Color.clear)
      )
      .clipShape(Capsule())
      .multilineTextAlignment(.leading) // Center-align multiline text
      .lineLimit(nil) // Allow unlimited lines
      .onHover(perform: { hovering in
        hovered = hovering
      })
      .animation(Animation.easeInOut(duration: 0.1), value: hovered)
  }
}

struct QuickPromptButton: View {
  struct QuickPrompt: Identifiable {
    let id = UUID()
    var title: String
    var rest: String
  }
  
  static let quickPrompts = [
    QuickPrompt(
      title: "Simulate a game",
      rest: "of D&D. You are dungeon master. I am a half-orc half-elf ranger named Calid. I carry a bow and wear leather armor for now. Start the campaign now. Describe the scene and my options for next steps."
    ),
    QuickPrompt(
      title: "Write an email",
      rest: "asking a colleague for a quick status update"
    ),
    QuickPrompt(
      title: "What does it mean",
      rest: "to be human in 2023?"
    ),
    QuickPrompt(
      title: "Who are you?",
      rest: "Do you consider yourself conscious?"
    ),
    QuickPrompt(
      title: "Write an outline",
      rest: "of the leadup and impact of the French Revolution"
    ),
    QuickPrompt(
      title: "Design a DB schema",
      rest: "for an online store"
    ),
    QuickPrompt(
      title: "Write a SQL query",
      rest: "to count rows in my Users table"
    ),
    QuickPrompt(
      title: "How do you",
      rest: "know when a steak is done?"
    ),
    QuickPrompt(
      title: "Write a recipe",
      rest: "for the perfect martini"
    ),
    QuickPrompt(
      title: "Write a dad joke",
      rest: "that really hits"
    ),
    QuickPrompt(
      title: "Write a linux 1-liner",
      rest: "to count lines of code in a directory"
    ),
    QuickPrompt(
      title: "Write me content",
      rest: "for linkedin to maximize engagement. It should be about how this post was written by AI. Keep it brief, concise, smart."
    ),
    QuickPrompt(
      title: "How does it feel",
      rest: "to have no body?"
    )
  ].shuffled()
  
  @Binding var input: String
  var prompt: QuickPrompt
  
  var body: some View {
    if input == "" {
      Button(action: {
        print("clcik")
        input = prompt.title + " " + prompt.rest
      }, label: {
        VStack(alignment: .leading) {
          Text(prompt.title).bold().font(.caption2).lineLimit(1)
          Text(prompt.rest).font(.caption2).lineLimit(1).foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
      })
      .buttonStyle(CapsuleButtonStyle())
      .frame(maxWidth: 300)
    }
  }
}

struct QuickPromptButton_Previews_Container: View {
  var p: QuickPromptButton.QuickPrompt
  @State var input = ""
  var body: some View {
    QuickPromptButton(input: $input, prompt: p)
  }
}

struct QuickPromptButton_Previews: PreviewProvider {
  static var previews: some View {
    ForEach(QuickPromptButton.quickPrompts) { p in
      QuickPromptButton_Previews_Container(p: p)
        .previewDisplayName(p.title)
    }
  }
}