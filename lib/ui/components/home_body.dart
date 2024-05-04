import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/todo_bloc/todo_bloc.dart';
import 'package:todo_list/ui/components/card_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoadingState) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 22),
              child: ListView.separated(
                itemBuilder: (context, i) {
                  return CardWidget(
                    title: '${state.notes[i].title}',
                    subTitle: '${state.notes[i].text}',
                    index: i,
                    state: AllTodoState(notes: state.notes),
                  );
                },
                separatorBuilder: (context, i) => const SizedBox(height: 0),
                itemCount: state.notes.length,
              ));
        }
        if (state is AllTodoState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 22),
            child: ListView.separated(
              itemBuilder: (context, i) {
                return CardWidget(
                  title: '${state.notes[i].title}',
                  subTitle: '${state.notes[i].text}',
                  index: i,
                  state: state,
                );
              },
              separatorBuilder: (context, i) => const SizedBox(height: 0),
              itemCount: state.notes.length,
            ),
          );
        }
        return const Text('Error');
      },
    );
  }
}
