<?= $this->session->flashdata('pesan'); ?>
<div class="card shadow-sm border-bottom-primary">
    <div class="card-header bg-white py-3">
        <div class="row">
            <div class="col">
                <h4 class="h5 align-middle m-0 font-weight-bold text-primary">
                    Riwayat Permintaan Barang
                </h4>
            </div>            
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-striped w-100 dt-responsive nowrap" id="dataTable">
            <thead>
                <tr>
                    <th>No. </th>
                    <th>No Permintaan</th>
                    <th>Tgl Permintaan</th>                    
                    <th>Nama Barang</th>
                    <th>Jumlah</th>
                    <th>Nama</th>   
                    <th>Unit</th>                  
                    <th>Detail</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $no = 1;
                if ($permintaan) :
                    foreach ($permintaan as $r) :
                        ?>
                        <tr>
                            <td><?= $no++; ?></td>
                            <td><?= $r['id_req']; ?></td>
                            <td><?= $r['tgl_req']; ?></td>
                            <td><?= $r['nama_barang']; ?></td>
                            <td><?= $r['jumlah'] . ' ' . $r['nama_satuan']; ?></td>                   
                            <td><?= $r['nama']; ?></td>
                            <td><?= $r['unit']; ?></td>
                            <td>
                                <a onclick="return confirm('Yakin ingin hapus?')" href="<?= base_url('permintaan/delete/') . $r['id_req'] ?>" class="btn btn-danger btn-circle btn-sm"><i class="fa fa-trash"></i></a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else : ?>
                    <tr>
                        <td colspan="8" class="text-center">
                            Data Kosong
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>