import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cat_bloc.dart';

class CatPage extends StatelessWidget {
  const CatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Кошки')),
        body: Center(
          child: BlocBuilder<CatBloc, dynamic>(
            builder: (context, state) {
              
              if (state is CatLoadingState) {
                return const CircularProgressIndicator();
              }

            
              if (state is CatErrorState) {
                return Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                );
              }

      
              if (state is CatLoadedState) {
                return ListView.builder(
                  itemCount: state.cats.length,
                  itemBuilder: (context, index) {
                    return Image.network(state.cats[index].url);
                  },
                );
              }

              
              return ElevatedButton(
                onPressed: () {
                  context.read<CatBloc>().add(LoadCatsEvent());
                },
                child: const Text('Загрузить котов'),
              );
            },
          ),
        ),
      ),
    );
  }
}
