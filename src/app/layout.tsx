import type { Metadata } from "next";
import "../globals.css";

export const metadata: Metadata = {
  title: "Todo App",
  description: "A simple todo list application",
};

export default function RootLayout({ children }: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" suppressHydrationWarning={true}>
      <body className="bg-gray-100 text-gray-800">
        <div className="container mx-auto p-4">
          {children}
        </div>
      </body>
    </html>
  );
}