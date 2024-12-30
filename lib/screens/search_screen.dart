import 'package:flutter/material.dart';
import 'package:itunes/components/search_bar.dart' as sbar;
import 'package:itunes/components/song_list.dart';
import 'package:itunes/viewmodels/search_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Taylor Swift'),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 'trackName',
                      groupValue: viewModel.sortOption,
                      onChanged: (value) {
                        viewModel.setSortOption(value!);
                      },
                    ),
                    Text('Songs'),
                    Radio(
                      value: 'collectionName',
                      groupValue: viewModel.sortOption,
                      onChanged: (value) {
                        viewModel.setSortOption(value!);
                      },
                    ),
                    Text('Albums'),
                  ],
                ),
                sbar.SearchBar(
                  onChanged: viewModel.setTerm,
                  onSubmitted: viewModel.searchSongs,
                ),
                if (viewModel.error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(viewModel.error,
                        style: TextStyle(color: Colors.red)),
                  ),
                Expanded(
                  child: SongList(songs: viewModel.songs),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: viewModel.currPage > 1
                            ? () => viewModel.prevPage()
                            : null,
                        icon: Icon(Icons.arrow_back)),
                    Text('Page ${viewModel.currPage}'),
                    IconButton(
                        onPressed: viewModel.currPage * viewModel.pageSize <
                                viewModel.totalNum
                            ? () {
                                viewModel.nextPage();
                              }
                            : null,
                        icon: Icon(Icons.arrow_forward)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
