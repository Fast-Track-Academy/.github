#!/bin/bash

# Fast Track Academy Student Setup Script
# This script helps new students set up their learning environment

set -e

echo "🚀 Welcome to Fast Track Academy!"
echo "Setting up your personalized learning environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if git is installed
check_git() {
    if command -v git &> /dev/null; then
        print_status "Git is installed"
        git --version
    else
        print_error "Git is not installed. Please install Git first."
        exit 1
    fi
}

# Check if Node.js is installed
check_nodejs() {
    if command -v node &> /dev/null; then
        print_status "Node.js is installed"
        node --version
        npm --version
    else
        print_warning "Node.js is not installed. Some projects may require it."
        print_info "Visit https://nodejs.org to install Node.js"
    fi
}

# Check if Python is installed
check_python() {
    if command -v python3 &> /dev/null; then
        print_status "Python 3 is installed"
        python3 --version
    elif command -v python &> /dev/null; then
        print_status "Python is installed"
        python --version
    else
        print_warning "Python is not installed. Many AI tools require Python."
        print_info "Visit https://python.org to install Python"
    fi
}

# Create student workspace
create_workspace() {
    local student_name="$1"
    local workspace_dir="$HOME/fast-track-academy"
    
    print_info "Creating workspace directory at $workspace_dir"
    
    mkdir -p "$workspace_dir"/{projects,notes,portfolio,resources}
    
    cat > "$workspace_dir/README.md" << EOF
# ${student_name}'s Fast Track Academy Workspace

Welcome to your personalized learning environment!

## Directory Structure
- \`projects/\` - Your coding and creative projects
- \`notes/\` - Learning notes and documentation
- \`portfolio/\` - Showcase of your best work
- \`resources/\` - Helpful learning materials and references

## Getting Started
1. Choose a learning track from the curriculum
2. Set up your first project in the projects directory
3. Start documenting your learning journey
4. Build your portfolio as you complete projects

## Quick Links
- [Curriculum Overview](https://github.com/Fast-Track-Academy/.github/blob/main/docs/curriculum/README.md)
- [AI Tools Guide](https://github.com/Fast-Track-Academy/.github/blob/main/docs/ai-tools/README.md)
- [Project Templates](https://github.com/Fast-Track-Academy/.github/blob/main/docs/projects/README.md)

Happy learning! 🚀
EOF

    print_status "Workspace created at $workspace_dir"
}

# Install recommended VS Code extensions
install_vscode_extensions() {
    if command -v code &> /dev/null; then
        print_info "Installing recommended VS Code extensions..."
        
        extensions=(
            "ms-python.python"
            "ms-vscode.vscode-typescript-next"
            "bradlc.vscode-tailwindcss"
            "formulahendry.auto-rename-tag"
            "ms-vscode.vscode-json"
            "yzhang.markdown-all-in-one"
            "GitHub.copilot"
            "ms-vscode.live-server"
            "ritwickdey.LiveServer"
            "esbenp.prettier-vscode"
        )
        
        for extension in "${extensions[@]}"; do
            code --install-extension "$extension" --force
        done
        
        print_status "VS Code extensions installed"
    else
        print_warning "VS Code not found. Install VS Code for the best development experience."
    fi
}

# Create learning goals template
create_learning_goals() {
    local student_name="$1"
    local goals_file="$HOME/fast-track-academy/learning-goals.md"
    
    cat > "$goals_file" << EOF
# ${student_name}'s Learning Goals

## Short-term Goals (Next 30 days)
- [ ] Complete initial skill assessment
- [ ] Choose primary learning track
- [ ] Set up development environment
- [ ] Complete first project
- [ ] Connect with mentor

## Medium-term Goals (Next 3 months)
- [ ] Master foundational skills in chosen track
- [ ] Complete 3 significant projects
- [ ] Contribute to open-source project
- [ ] Present work to peer group
- [ ] Expand to secondary learning track

## Long-term Goals (Next 12 months)
- [ ] Build comprehensive project portfolio
- [ ] Develop expertise in specialized area
- [ ] Mentor newer students
- [ ] Create original learning resources
- [ ] Pursue advanced opportunities

## Reflection Questions
1. What am I most excited to learn about?
2. What challenges do I anticipate?
3. How will I measure my progress?
4. What support do I need to succeed?

## Progress Tracking
Update this file weekly with your progress and reflections.

---
*Created on $(date '+%Y-%m-%d')*
EOF

    print_status "Learning goals template created"
}

# Main setup function
main() {
    echo
    echo "🎓 Fast Track Academy Student Environment Setup"
    echo "=============================================="
    echo
    
    # Get student information
    read -p "What's your name? " student_name
    read -p "What's your primary area of interest? (STEM/Digital/Creative/Communication/Global/Entrepreneurship) " interest_area
    
    echo
    print_info "Setting up environment for $student_name..."
    print_info "Primary interest: $interest_area"
    echo
    
    # System checks
    echo "🔍 Checking system requirements..."
    check_git
    check_nodejs
    check_python
    echo
    
    # Create workspace
    create_workspace "$student_name"
    echo
    
    # Create learning goals
    create_learning_goals "$student_name"
    echo
    
    # Install VS Code extensions
    install_vscode_extensions
    echo
    
    # Final instructions
    echo "🎉 Setup Complete!"
    echo "=================="
    echo
    print_status "Your learning environment is ready!"
    echo
    print_info "Next steps:"
    echo "1. Open your workspace: cd $HOME/fast-track-academy"
    echo "2. Review the curriculum at: https://github.com/Fast-Track-Academy/.github"
    echo "3. Join our Discord community for support and collaboration"
    echo "4. Start with your first project in the $interest_area track"
    echo
    print_info "Need help? Create an issue at: https://github.com/Fast-Track-Academy/.github/issues"
    echo
    echo "🚀 Happy learning, $student_name!"
}

# Run the setup
main "$@"