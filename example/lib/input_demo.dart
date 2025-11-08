import 'package:flutter/material.dart';
import 'package:zoni_ui/zoni_ui.dart';

/// Demo page showcasing enhanced ZoniTextField with decoration support.
class InputDemo extends StatefulWidget {
  const InputDemo({super.key});

  @override
  State<InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  ZoniInputVariant _selectedVariant = ZoniInputVariant.outlined;
  ZoniInputSize _selectedSize = ZoniInputSize.medium;
  bool _enableHapticFeedback = true;
  bool _enableFocusAnimation = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZoniTextField Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Controls Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Controls',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      
                      // Variant Selection
                      Text('Variant:', style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ZoniInputVariant.values.map((variant) {
                          return ChoiceChip(
                            label: Text(variant.name),
                            selected: _selectedVariant == variant,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedVariant = variant);
                              }
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      
                      // Size Selection
                      Text('Size:', style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ZoniInputSize.values.map((size) {
                          return ChoiceChip(
                            label: Text(size.name),
                            selected: _selectedSize == size,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedSize = size);
                              }
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      
                      // Feature Toggles
                      SwitchListTile(
                        title: const Text('Haptic Feedback'),
                        value: _enableHapticFeedback,
                        onChanged: (value) {
                          setState(() => _enableHapticFeedback = value);
                        },
                      ),
                      SwitchListTile(
                        title: const Text('Focus Animation'),
                        value: _enableFocusAnimation,
                        onChanged: (value) {
                          setState(() => _enableFocusAnimation = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Demo Form Section
              Text(
                'Enhanced ZoniTextField Examples',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // Email Field with Custom Decoration
              ZoniTextField(
                controller: _emailController,
                variant: _selectedVariant,
                size: _selectedSize,
                enableHapticFeedback: _enableHapticFeedback,
                enableFocusAnimation: _enableFocusAnimation,
                decoration: ZoniInputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  helperText: 'We\'ll never share your email',
                  prefixIcon: const Icon(Icons.email),
                  suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Password Field
              ZoniTextField(
                controller: _passwordController,
                variant: _selectedVariant,
                size: _selectedSize,
                enableHapticFeedback: _enableHapticFeedback,
                enableFocusAnimation: _enableFocusAnimation,
                decoration: ZoniInputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: const Icon(Icons.visibility),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Name Field with Error State
              ZoniTextField(
                controller: _nameController,
                variant: _selectedVariant,
                size: _selectedSize,
                enableHapticFeedback: _enableHapticFeedback,
                enableFocusAnimation: _enableFocusAnimation,
                decoration: ZoniInputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  errorText: _nameController.text.isEmpty ? 'Name is required' : null,
                  prefixIcon: const Icon(Icons.person),
                ),
                onChanged: (value) => setState(() {}),
              ),
              const SizedBox(height: 16),
              
              // Multi-line Message Field
              ZoniTextField(
                controller: _messageController,
                variant: _selectedVariant,
                size: _selectedSize,
                enableHapticFeedback: _enableHapticFeedback,
                enableFocusAnimation: _enableFocusAnimation,
                decoration: ZoniInputDecoration(
                  labelText: 'Message',
                  hintText: 'Enter your message here...',
                  helperText: 'Maximum 500 characters',
                  prefixIcon: const Icon(Icons.message),
                ),
                maxLines: 4,
                maxLength: 500,
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ZoniButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Form'),
                ),
              ),
              const SizedBox(height: 16),
              
              // Backward Compatibility Example
              Text(
                'Backward Compatibility (Legacy Parameters)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ZoniTextField(
                label: 'Legacy Label',
                hintText: 'Legacy hint text',
                helperText: 'Using legacy parameters',
                prefixIcon: const Icon(Icons.info),
                variant: _selectedVariant,
                size: _selectedSize,
                enableHapticFeedback: _enableHapticFeedback,
                enableFocusAnimation: _enableFocusAnimation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
