import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/config/routes/app_routes.dart';
import 'package:todo/config/theme/app_colors.dart';
import 'package:todo/config/theme/app_styles.dart';
import 'package:todo/core/services/get_it_service.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_text_field.dart';
import 'package:todo/features/todo/data/models/todo_model.dart';
import 'package:todo/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TodoCubit>()..fetchTodos(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              onPressed: () => showModalBottomSheet(
                backgroundColor: AppColors.lightBlue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                context: context,
                isScrollControlled: true,
                builder: (sheetContext) {
                  return BlocProvider.value(
                    value: context.read<TodoCubit>(),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 24,
                        bottom:
                            MediaQuery.of(sheetContext).viewInsets.bottom + 24,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Todo',
                            style: AppStyles.medium20.copyWith(
                              color: AppColors.dark,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Title',
                            controller: titleController,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            label: 'Description',
                            controller: descriptionController,
                          ),
                          const SizedBox(height: 16),
                          Builder(
                            builder: (btnContext) => CustomButton(
                              text: 'Add',
                              onPressed: () {
                                btnContext.read<TodoCubit>().addTodo(
                                  TodoModel(
                                    id: const Uuid().v4(),
                                    uid:
                                        getIt<FirebaseAuth>()
                                            .currentUser
                                            ?.uid ??
                                        '',
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    createdAt: DateTime.now(),
                                    isCompleted: false,
                                  ),
                                );
                                titleController.clear();
                                descriptionController.clear();
                                Navigator.pop(sheetContext);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              child: const Icon(Icons.add, color: AppColors.white),
            ),
            backgroundColor: AppColors.lightBlue,
            appBar: AppBar(
              elevation: 4,
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
              title: Text(
                'Home',
                style: AppStyles.medium20.copyWith(color: AppColors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () => context.go(AppRoutes.login),
                  icon: const Icon(Icons.logout, color: AppColors.white),
                ),
              ],
            ),
            body: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoError) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return const Center(child: Text('No tasks yet!'));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.todos.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ListTile(
                        tileColor: AppColors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: Checkbox(
                          activeColor: AppColors.success,
                          value: todo.isCompleted,
                          onChanged: (value) {
                            if (value == null) return;
                            final updatedTodo = TodoModel(
                              id: todo.id,
                              uid: todo.uid,
                              title: todo.title,
                              description: todo.description,
                              createdAt: todo.createdAt,
                              isCompleted: value,
                            );
                            context.read<TodoCubit>().updateTodo(updatedTodo);
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: AppStyles.medium16.copyWith(
                            color: AppColors.dark,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Text(
                          todo.description,
                          style: AppStyles.medium14.copyWith(
                            color: AppColors.grey,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.error,
                          ),
                          onPressed: () {
                            context.read<TodoCubit>().deleteTodo(todo.id);
                          },
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
